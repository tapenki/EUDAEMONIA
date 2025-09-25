extends Node

@onready var physics_space = PhysicsServer2D.body_get_space(get_node("/root/Main/Entities/Player").get_rid())

@onready var camera = $Camera2D

@onready var spawns = $Spawns
@onready var enemy_spawn_timer = $EnemySpawnTimer
@onready var spawn_reticle = preload("res://generic/spawn_reticle.tscn")

var summon_formations = {
	"4wall" : [
		[
			Vector2(860, 300),
			Vector2(40, 300),
			Vector2(450, 560),
			Vector2(450, 40)
		],
		[
			Vector2(860, 560),
			Vector2(860, 40),
			Vector2(40, 560),
			Vector2(40, 40)
		],
	],
	"4far" : [
		[
			Vector2(800, 300),
			Vector2(100, 300),
			Vector2(450, 500),
			Vector2(450, 100)
		],
		[
			Vector2(800, 500),
			Vector2(800, 100),
			Vector2(100, 500),
			Vector2(100, 100)
		],
	],
	"2far" : [
		[
			Vector2(800, 300),
			Vector2(100, 300),
		],
		[
			Vector2(450, 500),
			Vector2(450, 100)
		],
	],
	"center" : [
		[
			Vector2(450, 300)
		],
	],
}

var sphere_data = {
	"vasis" : {
		"tilemap" : preload("res://spheres/vasis/tilemap.png"),
		"common_waves" : [
			#[{"enemy" : preload("res://spheres/vasis/leaper/leaper.tscn"), "formation" : "4far"}],
			#[{"enemy" : preload("res://spheres/vasis/spitter/spitter.tscn"), "formation" : "4far"}],
			[{"enemy" : preload("res://spheres/thayma/mold/mold.tscn"), "formation" : "4wall"}],
		],
		"special_waves" : [
			[
				{"enemy" : preload("res://spheres/vasis/giga_leaper/giga_leaper.tscn"), "offset" : [Vector2(300, 0)]},
				{"enemy" : preload("res://spheres/vasis/giga_spitter/giga_spitter.tscn"), "offset" : [Vector2(-300, 0)]}
			],
		]
	},
	"thayma" : {
		"tilemap" : preload("res://spheres/thayma/tilemap.png"),
		"common_waves" : [
			[{"enemy" : preload("res://spheres/thayma/trispitter/trispitter.tscn"), "formation" : "4far"}],
			[{"enemy" : preload("res://spheres/thayma/rocketjumper/rocketjumper.tscn"), "formation" : "4far"}],
		],
		"special_waves" : [
			[
				{"enemy" : preload("res://spheres/vasis/giga_leaper/giga_leaper.tscn"), "offset" : [Vector2(300, 0)]},
				{"enemy" : preload("res://spheres/vasis/giga_spitter/giga_spitter.tscn"), "offset" : [Vector2(-300, 0)]}
			],
		]
	},
	"aporia" : {
		"tilemap" : preload("res://spheres/aporia/tilemap.png"),
		"common_waves" : [
			[{"enemy" : preload("res://spheres/aporia/hydra/hydra.tscn"), "formation" : "4far"}],
			[{"enemy" : preload("res://spheres/aporia/spitball/spitball.tscn"), "formation" : "4far"}],
			[{"enemy" : preload("res://spheres/aporia/leaker/leaker.tscn"), "formation" : "4far"}],
		],
		"special_waves" : [
			[
				{"enemy" : preload("res://spheres/vasis/giga_leaper/giga_leaper.tscn"), "offset" : [Vector2(300, 0)]},
				{"enemy" : preload("res://spheres/vasis/giga_spitter/giga_spitter.tscn"), "offset" : [Vector2(-300, 0)]}
			],
		]
	},
	"pandemonium" : {
		"tilemap" : preload("res://tilemap.png"),
		"common_waves" : [
			[{"enemy" : preload("res://spheres/aporia/hydra/hydra.tscn"), "formation" : "4far"}],
			[{"enemy" : preload("res://spheres/aporia/spitball/spitball.tscn"), "formation" : "4far"}],
			[{"enemy" : preload("res://spheres/aporia/leaker/leaker.tscn"), "formation" : "4far"}],
			[{"enemy" : preload("res://spheres/vasis/leaper/leaper.tscn"), "formation" : "4far", "offset" : [Vector2(25, 0), Vector2(-25, 0), Vector2(0, -25)]}],
			[{"enemy" : preload("res://spheres/vasis/spitter/spitter.tscn"), "formation" : "4far", "offset" : [Vector2(25, 0), Vector2(-25, 0), Vector2(0, -25)]}],
			[{"enemy" : preload("res://spheres/thayma/trispitter/trispitter.tscn"), "formation" : "4far", "offset" : [Vector2(25, 0), Vector2(-25, 0)]}],
			[{"enemy" : preload("res://spheres/thayma/rocketjumper/rocketjumper.tscn"), "formation" : "4far", "offset" : [Vector2(25, 0), Vector2(-25, 0)]}],
		],
		"special_waves" : [
			[
				{"enemy" : preload("res://spheres/vasis/giga_leaper/giga_leaper.tscn"), "offset" : [Vector2(300, 0)]},
				{"enemy" : preload("res://spheres/vasis/giga_spitter/giga_spitter.tscn"), "offset" : [Vector2(-300, 0)]}
			],
		]
	}
}
var sphere_tiers = {
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
		"pandemonium"
	],
}
var max_tier = 1

var sphere = "vasis"
var sphere_tier = 1
var day = 1
var bad_day = false
var day_over = true

var enemy_queue: Array

### signals

signal entity_death(entity: Entity)
signal day_start(day: int)
signal day_cleared(day: int)
signal intermission(day: int)
signal failed()

### methods
func _ready() -> void:
	travel(sphere)

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
func spawn_entity(entity: Entity):
	var reticle_instance = spawn_reticle.instantiate()
	reticle_instance.global_position = entity.global_position
	reticle_instance.entity = entity
	reticle_instance.modulate = entity.get_node("Sprite").modulate
	spawns.add_child(reticle_instance)

func instantiate_enemy(scene: PackedScene):
	var entity_instance = scene.instantiate()
	assign_entity_group(entity_instance, 2, "primary")
	entity_instance.max_health *= pow(1.25, day-1)
	entity_instance.health = entity_instance.max_health
	entity_instance.ability_handler.inherited_damage["multiplier"] = 0.75 + (day * 0.25)
	return entity_instance

func _on_enemy_spawn_timeout() -> void:
	for enemy_group in enemy_queue[0]:
		var positions = summon_formations[enemy_group.get("formation", "center")].pick_random()
		for position in positions:
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
		enemy_spawn_timer.start(4)

## day progress
func travel(to_sphere: String):
	get_node("TileMapLayer").tile_set.get_source(1).texture = sphere_data[to_sphere]["tilemap"]

func start_day():
	day_over = false
	day_start.emit(day)
	
	for i in 2:
		if bad_day and i == 0:
			var chosen_wave
			chosen_wave = sphere_data[sphere]["special_waves"].pick_random()
			enemy_queue.append(chosen_wave)
		else:
			var chosen_wave
			chosen_wave = sphere_data[sphere]["common_waves"].pick_random()
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
			camera.get_node("AnimationPlayer").play("ZOOM")
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
				get_node("/root/Main/UI").upgrade_points += 1
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
		if sphere_tiers.has(sphere_tier + 1):
			sphere_tier += 1
			sphere = sphere_tiers[sphere_tier].pick_random()
	if day % 5 == 0:
		bad_day = true
	intermission.emit(day)
	Saver.write()

## special effects
func play_sound(sound: String):
	get_node("Audio/" + sound).play()

func spawn_particles(particle_scene: PackedScene, position: Vector2, scale: float = 1, color: Color = Color.WHITE):
	var particle_instance = particle_scene.instantiate()
	particle_instance.global_position = position
	particle_instance.modulate = color
	particle_instance.process_material.scale *= scale
	particle_instance.scale = Vector2(scale, scale)
	add_child(particle_instance)
	particle_instance.timer.start()
	return particle_instance

func particle_beam(particle_scene: PackedScene, start: Vector2, end: Vector2, spacing: float = 32, scale: float = 1, color: Color = Color.WHITE):
	var particle_instance: GPUParticles2D = particle_scene.instantiate()
	particle_instance.modulate = color
	particle_instance.process_material.scale *= scale
	particle_instance.scale = Vector2(scale, scale)
	add_child(particle_instance)
	particle_instance.timer.start()
	
	var distance = start.distance_to(end)
	var dir = start.direction_to(end)
	var progress = 0.0
	while progress < distance:
		progress += spacing
		particle_instance.emit_particle(Transform2D(0, start + dir * progress), Vector2(), color, color, 1)
	return particle_instance
