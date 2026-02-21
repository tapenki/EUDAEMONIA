extends Node

@onready var physics_space = get_viewport().world_2d.direct_space_state
@onready var saver = $Saver

@onready var player = get_node("/root/Main/Entities/Player")

@onready var particles = $Particles

@onready var spawns = $Spawns
@onready var spawn_reticle = preload("res://generic/entities/spawn_reticle.tscn")

var astar = AStarGrid2D.new()

var room_node: Node
@export var room = "vasis_entrance_hall"
var door = "Entrance0"

var day = 1
var day_started = false

var enemy_queue: Array

var game_over: bool

### signals

signal camera_parameters(zoom_scale: float)#, left: int, top: int, right: int, bottom: int)
signal screenshake(intensity: float)

signal entity_death(entity: Entity)

signal wave_start(wave: Wave)
signal wave_cleared()

signal day_start(day: int)
signal day_cleared(day: int)
signal intermission(day: int)

signal game_start()

signal failed()

### methods

## groups 
func assign_projectile_group(projectile: Projectile, group: int, color: String = "secondary"):
	projectile.group = group
	for i in range(1, 3):
			projectile.set_collision_mask_value(i, i != group)
	projectile.set_collision_layer_value(group, true)
	projectile.apply_palette(group, color)

func assign_entity_group(entity: Entity, group: int, color: String = "secondary"):
	entity.group = group
	var hurtbox = entity.get_node_or_null("Hurtbox")
	if hurtbox:
		for i in range(1, 3):
			hurtbox.set_collision_mask_value(i, i != group)
	entity.set_collision_layer_value(group, true)
	entity.apply_palette(group, color)

## entity spawning
func scale_enemy_health(health: float):
	return health * (1 + 0.05 * pow(day-1, 2))

func scale_enemy_damage():
	return 0.75 + (day * 0.25)

func spawn_entity(entity: Entity, delay = 0.5):
	var reticle_instance = spawn_reticle.instantiate()
	reticle_instance.global_position = entity.global_position
	reticle_instance.set_spawn(entity)
	spawns.add_child(reticle_instance)
	reticle_instance.get_node("SpawnTimer").start(delay)

func instantiate_enemy(scene: PackedScene):
	var entity_instance = scene.instantiate()
	assign_entity_group(entity_instance, 2, "primary")
	entity_instance.max_health = scale_enemy_health(entity_instance.max_health)
	entity_instance.health = entity_instance.max_health
	entity_instance.ability_handler.inherited_damage["multiplier"] = scale_enemy_damage()
	return entity_instance

## map
func generate_map():
	if room_node != null:
		room_node.queue_free()
	var room_data = RegionData.room_data[room]#region_data[region]["layouts"][layout_id]
	room_node = room_data["scene"].instantiate()
	add_child(room_node)
	#generate_nav_polygon()
	setup_astar()
	var entrance_door = room_node.get_node("Doors/"+door)
	player.global_position = entrance_door.global_position + Vector2(0, 60).rotated(entrance_door.rotation)
	camera_parameters.emit(room_data["zoom_scale"])#, layout_data["left"], layout_data["top"], layout_data["right"], layout_data["bottom"])

func setup_astar():
	astar.clear()
	var tilemap = room_node.get_node("TileMap")
	astar.region = tilemap.get_used_rect()
	astar.cell_size = tilemap.tile_set.tile_size
	astar.offset = astar.cell_size * 0.5
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_CHEBYSHEV
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_CHEBYSHEV
	astar.update()
	
	for i in range(astar.region.position.x, astar.region.end.x):
		for j in range(astar.region.position.y, astar.region.end.y):
			var pos = Vector2i(i, j)
			if tilemap.get_cell_source_id(pos) != 2:
				astar.set_point_solid(pos)
				for k in range(-2, 3):
					for l in range(-2, 3):
						if astar.is_in_boundsv(pos + Vector2i(k, l)):
							astar.set_point_weight_scale(pos + Vector2i(k, l), 4)

func pathfind(start, end):
	var tilemap = room_node.get_node("TileMap")
	start = tilemap.local_to_map(start)
	end = tilemap.local_to_map(end)
	if not astar.is_in_boundsv(start) or not astar.is_in_boundsv(end):
		return PackedVector2Array()
	var path = astar.get_point_path(start, end, true)
	
	## path post processing and the bane of my existence
	if path.size() != 0:
		var pruned = 0
		var prev_position = null
		var prev_offset = null
		var offset_decay = 0
		for i in path.size():
			var next_position = path[path.size() + pruned - i - 1]
			if prev_position != null:
				var next_offset = prev_position - next_position
				if prev_offset != null:
					if (prev_offset.x == next_offset.x or prev_offset.y == next_offset.y) and prev_offset.x != next_offset.x * -1 and prev_offset.y != next_offset.y * -1 and offset_decay < 2:
						path.remove_at(path.size() + pruned - i - 1)
						pruned += 1
						if prev_offset.x != next_offset.x or prev_offset.y != next_offset.y:
							offset_decay += 1
						elif offset_decay > 0:
							offset_decay -= 1
					else:
						prev_offset = next_offset
						offset_decay = 0
				else:
					prev_offset = next_offset
			prev_position = next_position
		if tilemap.local_to_map(path[0]) == start:
			path.remove_at(0)
	
	return path

## day progress

func start_day():
	generate_map()
	day_started = true
	day_start.emit(day)

func check_finished(dying_entity):
	if dying_entity is Player: ## failstate
		var players_alive = false
		for entity in get_node("/root/Main/Entities").get_children():
			if entity is Player and entity.alive:
				players_alive = true
				break
		if not players_alive:
			game_over = true
			failed.emit()
			saver.erase_run()
			#var tween = create_tween()
			#tween.tween_property(camera, "zoom", Vector2(2, 2), 15)
	elif not dying_entity.summoned: ## check wave progress
		var enemies_alive = false
		for entity in get_node("/root/Main/Entities").get_children():
			if entity.alive and entity.group == 2 and not entity.summoned:
				enemies_alive = true
				break
		for spawn in spawns.get_children():
			if not spawn.is_queued_for_deletion() and spawn.entity.group == 2 and not spawn.entity.summoned:
				enemies_alive = true
				break
		if enemies_alive: return ## return if there's still enemies left alive
		wave_cleared.emit()

func full_clear():
	play_sound("Completion")
	day_cleared.emit(day)

func travel(to_room, to_door):
	for entity in get_node("/root/Main/Entities").get_children():
		if not entity is Player:
			entity.queue_free()
	for projectile in get_node("/root/Main/Projectiles").get_children():
		projectile.queue_free()
	day_started = false
	room = to_room
	door = to_door
	intermission.emit(day)
	saver.write_run()

## special effects
func play_sound(sound: String, pitch_scale = randf_range(0.9, 1.1)):
	var node = get_node("Audio/" + sound)
	node.pitch_scale = pitch_scale
	node.play()

func spawn_particles(particle_instance: GPUParticles2D, count: int, position: Vector2, scale: float = 1, color: Color = Color.WHITE):
	for i in count:
		particle_instance.emit_particle(Transform2D(0, Vector2(scale, scale), 0, position), Vector2(), color, Color(), 11)

func particle_beam(particle_instance: GPUParticles2D, start: Vector2, end: Vector2, spacing: int = 32, scale: float = 1, color: Color = Color.WHITE):
	var distance = start.distance_to(end)
	var delta = 0
	while delta < distance:
		delta += spacing
		particle_instance.emit_particle(Transform2D(0, Vector2(scale, scale), 0, start.move_toward(end, delta)), Vector2(), color, Color(), 11)
	return particle_instance

@onready var floating_text_scene = preload("res://generic/misc/floating_text.tscn")
func floating_text(text_position: Vector2, text: String, color: Color):
	if not Config.config.get_value("gameplay", "damage_numbers"):
		return
	var instance = floating_text_scene.instantiate()
	instance.position = text_position
	instance.get_node("Label").text = text
	instance.modulate = color
	add_child(instance)
