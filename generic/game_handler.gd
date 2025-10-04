extends Node

@onready var player = get_node("/root/Main/Entities/Player")
@onready var physics_space = get_viewport().world_2d.direct_space_state

@onready var particles = $Particles

@onready var spawns = $Spawns
@onready var enemy_spawn_timer = $EnemySpawnTimer
@onready var spawn_reticle = preload("res://generic/entities/spawn_reticle.tscn")

var region_data = {
	"vasis" : {
		"layouts" : [
			{
				"scene" : preload("res://regions/vasis/layouts/vasis_layout_0.tscn"), 
				"zoom_scale" : 0.9, 
			},
		],
		"common_waves" : [
			[{"enemy" : preload("res://regions/vasis/leaper/leaper.tscn"), "positions" : ["OuterTopLeft", "OuterTopRight", "OuterBottomLeft", "OuterBottomRight"]}],
			[{"enemy" : preload("res://regions/vasis/spitter/spitter.tscn"), "positions" : ["OuterTopLeft", "OuterTopRight", "OuterBottomLeft", "OuterBottomRight"]}],
		],
		"special_waves" : [
			[
				{"enemy" : preload("res://regions/vasis/giga_leaper/giga_leaper.tscn"), "positions" : ["OuterRight"]},
				{"enemy" : preload("res://regions/vasis/giga_spitter/giga_spitter.tscn"), "positions" : ["OuterLeft"]}
			],
		]
	},
	"thayma" : {
		"layouts" : [
			{
				"scene" : preload("res://regions/thayma/layouts/thayma_layout_0.tscn"), 
				"zoom_scale" : 0.9, 
			},
		],
		"common_waves" : [
			[{"enemy" : preload("res://regions/thayma/trispitter/trispitter.tscn"), "positions" : ["OuterTopLeft", "OuterTopRight", "OuterBottomLeft", "OuterBottomRight"]}],
			[{"enemy" : preload("res://regions/thayma/breaker/breaker.tscn"), "positions" : ["OuterLeft", "OuterRight"]}],
			[{"enemy" : preload("res://regions/thayma/mars/mars.tscn"), "positions" : ["OuterLeft", "OuterRight"]}],
		],
		"special_waves" : [
			[{"enemy" : preload("res://regions/thayma/saturn/saturn.tscn"), "positions" : ["OuterTop"]}],
		]
	},
	"aporia" : {
		"layouts" : [
			{
				"scene" : preload("res://regions/aporia/layouts/aporia_layout_0.tscn"), 
				"zoom_scale" : 0.9, 
			},
		],
		"common_waves" : [
			[{"enemy" : preload("res://regions/aporia/spitball/spitball.tscn"), "positions" : ["OuterTopLeft", "OuterTopRight", "OuterBottomLeft", "OuterBottomRight"]}],
			[{"enemy" : preload("res://regions/aporia/leaker/leaker.tscn"), "positions" : ["OuterTopLeft", "OuterTopRight", "OuterBottomLeft", "OuterBottomRight"]}],
			[{"enemy" : preload("res://regions/aporia/mold/mold.tscn"), "positions" : ["WallLeft", "WallTop", "WallRight", "WallBottom"]}],
		],
		"special_waves" : [
			[{"enemy" : preload("res://regions/aporia/mold_mother/mold_mother.tscn"), "positions" : ["WallTop"]}],
		]
	},
	"olethros" : {
		"layouts" : [
			{
				"scene" : preload("res://regions/olethros/layouts/olethros_layout_0.tscn"), 
				"zoom_scale" : 0.9, 
			},
		],
		"common_waves" : [
			[{"enemy" : preload("res://regions/olethros/hydra/hydra.tscn"), "positions" : ["OuterTopLeft", "OuterTopRight", "OuterBottomLeft", "OuterBottomRight"]}],
			[{"enemy" : preload("res://regions/olethros/rocketjumper/rocketjumper.tscn"), "positions" : ["OuterTopLeft", "OuterTopRight", "OuterBottomLeft", "OuterBottomRight"]}],
			[{"enemy" : preload("res://regions/aporia/mold/mold.tscn"), "positions" : ["WallLeft", "WallTop", "WallRight", "WallBottom"]}],
		],
		"special_waves" : [
			[{"enemy" : preload("res://regions/aporia/mold_mother/mold_mother.tscn"), "positions" : ["WallTop"]}],
		]
	},
	"pandemonium" : {
		"wavecount" : 3,
		"layouts" : [
			{
				"scene" : preload("res://regions/vasis/layouts/vasis_layout_0.tscn"), 
				"zoom_scale" : 0.9, 
			},
			{
				"scene" : preload("res://regions/thayma/layouts/thayma_layout_0.tscn"), 
				"zoom_scale" : 0.9, 
			},
			{
				"scene" : preload("res://regions/aporia/layouts/aporia_layout_0.tscn"), 
				"zoom_scale" : 0.9, 
			},
			{
				"scene" : preload("res://regions/olethros/layouts/olethros_layout_0.tscn"), 
				"zoom_scale" : 0.9, 
			},
		],
		"common_waves" : [
			[{"enemy" : preload("res://regions/thayma/trispitter/trispitter.tscn"), "positions" : ["OuterTopLeft", "OuterTopRight", "OuterBottomLeft", "OuterBottomRight"]}],
			[{"enemy" : preload("res://regions/olethros/rocketjumper/rocketjumper.tscn"), "positions" : ["OuterTopLeft", "OuterTopRight", "OuterBottomLeft", "OuterBottomRight"]}],
			[{"enemy" : preload("res://regions/aporia/mold/mold.tscn"), "positions" : ["WallLeft", "WallTop", "WallRight", "WallBottom"]}],
			[{"enemy" : preload("res://regions/olethros/hydra/hydra.tscn"), "positions" : ["OuterTopLeft", "OuterTopRight", "OuterBottomLeft", "OuterBottomRight"]}],
			[{"enemy" : preload("res://regions/aporia/spitball/spitball.tscn"), "positions" : ["OuterTopLeft", "OuterTopRight", "OuterBottomLeft", "OuterBottomRight"]}],
			[{"enemy" : preload("res://regions/aporia/leaker/leaker.tscn"), "positions" : ["OuterTopLeft", "OuterTopRight", "OuterBottomLeft", "OuterBottomRight"]}],
			[{"enemy" : preload("res://regions/thayma/mars/mars.tscn"), "positions" : ["OuterLeft", "OuterRight"]}],
		],
		"special_waves" : [
			[
				{"enemy" : preload("res://regions/vasis/giga_leaper/giga_leaper.tscn"), "positions" : ["OuterRight"]},
				{"enemy" : preload("res://regions/vasis/giga_spitter/giga_spitter.tscn"), "positions" : ["OuterLeft"]}
			],
			[{"enemy" : preload("res://regions/aporia/mold_mother/mold_mother.tscn"), "positions" : ["WallTop"]}],
			[{"enemy" : preload("res://regions/thayma/saturn/saturn.tscn"), "positions" : ["OuterTop"]}],
		]
	}
}
var sphere_data = {
	1 : [
		"vasis"
	],
	2 : [
		"thayma"
	],
	3 : [
		"aporia"
	],
	4 : [
		"olethros"
	],
	5 : [
		"pandemonium"
	],
}

var region = "vasis"
var sphere = 1

var layout: Node
var layout_id: int

var day = 1
var bad_day = false
var day_over = true

var enemy_queue: Array

### signals

signal camera_parameters(zoom_scale: float)#, left: int, top: int, right: int, bottom: int)
signal screenshake(intensity: float)

signal entity_death(entity: Entity)
signal day_start(day: int)
signal day_cleared(day: int)
signal intermission(day: int)
signal failed()

### methods
func _ready() -> void:
	travel(region)

## groups 
func assign_projectile_group(projectile: Projectile, group: int, color: String = "secondary"):
	projectile.group = group
	for i in range(1, 3):
			projectile.set_collision_mask_value(i, i != group)
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

func _on_enemy_spawn_timeout() -> void:
	for enemy_group in enemy_queue[0]:
		for position in enemy_group["positions"]:
			position = layout.get_node("Positions/%s" % position).global_position
			if enemy_group.has("offset"):
				for offset in enemy_group["offset"]:
					var enemy_instance = instantiate_enemy(enemy_group["enemy"])
					enemy_instance.position = position + offset
					spawn_entity(enemy_instance)
			else:
				var enemy_instance = instantiate_enemy(enemy_group["enemy"])
				enemy_instance.position = position
				spawn_entity(enemy_instance)
	enemy_queue.remove_at(0)
	if not enemy_queue.is_empty():
		enemy_spawn_timer.start(2.5)

## day progress
func travel(to_region: String):
	region = to_region
	pass

func generate_map():
	if layout != null:
		layout.queue_free()
	var layout_data = region_data[region]["layouts"][layout_id]
	layout = layout_data["scene"].instantiate()
	add_child(layout)
	player.global_position = layout.get_node("Positions/InnerBottom").global_position
	camera_parameters.emit(layout_data["zoom_scale"])#, layout_data["left"], layout_data["top"], layout_data["right"], layout_data["bottom"])

func start_day():
	generate_map()
	day_over = false
	day_start.emit(day)
	
	for i in region_data[region].get("wavecount", 2):
		if bad_day and i == 0:
			var chosen_wave
			chosen_wave = region_data[region]["special_waves"].pick_random()
			enemy_queue.append(chosen_wave)
		else:
			var chosen_wave
			chosen_wave = region_data[region]["common_waves"].pick_random()
			enemy_queue.append(chosen_wave)
	_on_enemy_spawn_timeout()

func check_finished(dying_entity):
	if dying_entity is Player: ## failstate
		var players_alive = false
		for entity in get_node("/root/Main/Entities").get_children():
			if entity is Player and entity.alive and not entity.is_queued_for_deletion():
				players_alive = true
				break
		if not players_alive:
			failed.emit()
			Saver.erase()
			#var tween = create_tween()
			#tween.tween_property(camera, "zoom", Vector2(2, 2), 15)
	elif not dying_entity.summoned: ## check day progress
		var enemies_alive = false
		for entity in get_node("/root/Main/Entities").get_children():
			if not entity.is_queued_for_deletion() and entity.alive and entity.group == 2 and not entity.summoned:
				enemies_alive = true
				break
		for spawn in spawns.get_children():
			if not spawn.is_queued_for_deletion() and spawn.entity.alive and spawn.entity.group == 2 and not spawn.entity.summoned:
				enemies_alive = true
				break
		if not enemy_queue.is_empty():
			if not enemies_alive and enemy_spawn_timer.time_left > 0.5:
				enemy_spawn_timer.start(0.5) ## spawn the next wave faster when clearing everything
			return ## return if there's still enemies left to spawn
		if enemies_alive: return ## return if there's still enemies left alive
		var players_alive = false
		for entity in get_node("/root/Main/Entities").get_children():
			if entity is Player:
				players_alive = true
		if players_alive:
			get_node("/root/Main/UI").upgrade_points += 1
			if bad_day:
				get_node("/root/Main/UI").unlock_points += 1
			day_cleared.emit(day)
			day_over = true

func end_day():
	for entity in get_node("/root/Main/Entities").get_children():
		if entity.summoned:
			entity.queue_free()
		elif entity is Player:
			entity.ability_handler.upgrade("bonus_health", 1)
			entity.ability_handler.recover()
	for projectile in get_node("/root/Main/Projectiles").get_children():
		projectile.queue_free()
	day += 1
	if bad_day:
		bad_day = false
		sphere += 1
		if sphere_data.has(sphere):
			travel(sphere_data[sphere].pick_random())
	if day % 5 == 0:
		bad_day = true
	layout_id = randi_range(0, region_data[region]["layouts"].size() - 1)
	intermission.emit(day)
	Saver.write()

## special effects
func play_sound(sound: String):
	get_node("Audio/" + sound).play()

func spawn_particles(particle_scene: PackedScene, position: Vector2, scale: float = 1, color: Color = Color.WHITE):
	#if particles.get_children().size() > 32:
	#	return
	var particle_instance = particle_scene.instantiate()
	particle_instance.global_position = position
	particle_instance.modulate = color
	particle_instance.process_material.scale *= scale
	particle_instance.scale = Vector2(scale, scale)
	particles.add_child(particle_instance)
	particle_instance.timer.start()
	return particle_instance

func particle_beam(particle_scene: PackedScene, start: Vector2, end: Vector2, spacing: int = 32, scale: float = 1, color: Color = Color.WHITE):
	#if particles.get_children().size() > 32:
	#	return
	var particle_instance: GPUParticles2D = particle_scene.instantiate()
	particle_instance.modulate = color
	particle_instance.process_material.scale *= scale
	particle_instance.scale = Vector2(scale, scale)
	particles.add_child(particle_instance)
	particle_instance.timer.start()
	
	var distance = start.distance_to(end)
	var delta = 0
	while delta < distance:
		delta += spacing
		particle_instance.emit_particle(Transform2D(0, start.move_toward(end, delta)), Vector2(), color, color, 1)
	return particle_instance

@onready var floating_text_scene = preload("res://generic/misc/floating_text.tscn")
func floating_text(text_position: Vector2, text: String, color: Color):
	var instance = floating_text_scene.instantiate()
	instance.position = text_position
	instance.get_node("Label").text = text
	instance.modulate = color
	add_child(instance)
