extends Node

@onready var player = get_node("/root/Main/Entities/Player")
@onready var physics_space = get_viewport().world_2d.direct_space_state

@onready var particles = $Particles

@onready var spawns = $Spawns
@onready var spawn_reticle = preload("res://generic/entities/spawn_reticle.tscn")

@onready var nav_polygon = $NavRegion.navigation_polygon
var astar = AStarGrid2D.new()

var region = "thayma"

var room_node: Node
var room = "thayma_room_0"
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

signal failed()

### methods

## groups 
func assign_projectile_group(projectile: Projectile, group: int, color: String = "secondary"):
	projectile.group = group
	for i in range(1, 3):
			projectile.set_collision_mask_value(i, i != group)
	projectile.set_collision_layer_value(group, true)
	projectile.get_node("Sprite").modulate = Config.get_team_color(group, color)

func assign_entity_group(entity: Entity, group: int, color: String = "secondary"):
	entity.group = group
	var hurtbox = entity.get_node_or_null("Hurtbox")
	if hurtbox:
		for i in range(1, 3):
			hurtbox.set_collision_mask_value(i, i != group)
	entity.set_collision_layer_value(group, true)
	entity.get_node("Sprite").modulate = Config.get_team_color(group, color)

## entity spawning
func scale_enemy_health(health: float):
	return health * pow(1.25, day-1)

func scale_enemy_damage():
	return 0.75 + (day * 0.25)

func spawn_entity(entity: Entity):
	var reticle_instance = spawn_reticle.instantiate()
	reticle_instance.global_position = entity.global_position
	reticle_instance.entity = entity
	reticle_instance.modulate = entity.get_node("Sprite").modulate
	spawns.add_child(reticle_instance)

func instantiate_enemy(scene: PackedScene):
	var entity_instance = scene.instantiate()
	assign_entity_group(entity_instance, 2, "primary")
	entity_instance.max_health = scale_enemy_health(entity_instance.max_health)
	entity_instance.health = entity_instance.max_health
	entity_instance.ability_handler.inherited_damage["multiplier"] = scale_enemy_damage()
	return entity_instance

## day progress
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
	var tilemap = room_node.get_node("TileMap")
	astar.region = tilemap.get_used_rect()
	astar.region.end.x += 1
	astar.region.end.y += 1
	astar.cell_size = tilemap.tile_set.tile_size
	astar.offset = astar.cell_size * 0.5
	astar.update()
	
	for i in range(astar.region.position.x, astar.region.end.x):
		for j in range(astar.region.position.y, astar.region.end.y):
			var pos = Vector2i(i, j)
			if tilemap.get_cell_source_id(pos) != 2:
				astar.set_point_solid(pos)

func generate_nav_polygon():
	var tilemap = room_node.get_node("TileMap")
	var usedRect = tilemap.get_used_rect()
	var outline = PackedVector2Array([
		Vector2(usedRect.position.x * 30, usedRect.position.y * 30),
		Vector2(usedRect.position.x * 30, usedRect.end.y * 30),
		Vector2(usedRect.end.x * 30, usedRect.end.y * 30),
		Vector2(usedRect.end.x * 30, usedRect.position.y * 30),
	])
	nav_polygon.clear_outlines()
	nav_polygon.add_outline(outline)
	var source_geometry_data = NavigationMeshSourceGeometryData2D.new()
	NavigationServer2D.parse_source_geometry_data(nav_polygon, source_geometry_data, tilemap)
	NavigationServer2D.bake_from_source_geometry_data(nav_polygon, source_geometry_data)

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
			Saver.erase()
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

func travel(to_room, to_door):
	for entity in get_node("/root/Main/Entities").get_children():
		if entity is Player:
			if RegionData.room_data[room].has("challenge"):
				entity.ability_handler.upgrade("bonus_health", 10)
			else:
				entity.ability_handler.upgrade("bonus_health", 5)
			entity.ability_handler.recover()
		else:
			entity.queue_free()
	for projectile in get_node("/root/Main/Projectiles").get_children():
		projectile.queue_free()
	get_node("/root/Main/UI").upgrade_points += 1
	if RegionData.room_data[room].has("challenge"):
		get_node("/root/Main/UI").unlock_points += 1
	day += 1
	day_started = false
	room = to_room
	door = to_door
	region = RegionData.room_data[room]["region"]
	intermission.emit(day)
	Saver.write()

## special effects
func play_sound(sound: String):
	get_node("Audio/" + sound).play()

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
