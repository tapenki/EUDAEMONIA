extends Ability

var bomb = preload("res://paths/ice/cryobomb/cryobomb.tscn")
var explosion_scene = preload("res://generic/projectiles/explosion.tscn")

func apply(ability_relay, applicant_data):
	if ability_relay.owner.scene_file_path == "res://paths/ice/cryobomb/cryobomb.tscn":
		applicant_data["bomb_primed"] = false
		applicant_data["bomb_timer"] = 3
		applicant_data["accumulated"] = 0
		ability_relay.damage_taken.connect(damage_taken.bind(ability_relay))
		ability_relay.before_self_death.connect(before_self_death)
		ability_relay.death_effects.connect(death_effects.bind(ability_relay))
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("accumulated"):
		applicant_data["accumulated"] = applicants[ability_relay.source]["accumulated"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_taken.is_connected(damage_taken):
		ability_relay.damage_taken.disconnect(damage_taken)
	if ability_relay.before_self_death.is_connected(before_self_death):
		ability_relay.before_self_death.disconnect(before_self_death)
	if ability_relay.death_effects.is_connected(death_effects):
		ability_relay.death_effects.disconnect(death_effects)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("bomb_primed") and applicants[ability_relay]["bomb_primed"]: 
			applicants[ability_relay]["bomb_timer"] -= delta * ability_relay.speed_scale
			if applicants[ability_relay]["bomb_timer"] <= 0:
				ability_relay.owner.kill()

func day_start(_day: int) -> void:
	for applicant in applicants:
		if applicants[applicant].has("subscription") and applicants[applicant]["subscription"] < 5:
			return
		for i in 2:
			var tilemap = get_node("/root/Main").room_node.get_node("TileMap")
			var cell = tilemap.get_used_cells_by_id(2).pick_random()
			var spawn_position = Vector2(cell * tilemap.tile_set.tile_size) + tilemap.tile_set.tile_size * 0.5
			var summon_instance = applicant.make_summon(bomb, 
			spawn_position,
			2)  ## inheritance
			for layer in range(1, 3):
				summon_instance.set_collision_layer_value(layer, layer != applicant.owner.group)
			
			summon_instance.max_health = 40*level
			summon_instance.health = summon_instance.max_health
			
			summon_instance.apply_palette(applicant.owner.group, "tertiary")
			
			get_node("/root/Main").spawn_entity(summon_instance)

func damage_taken(damage, ability_relay) -> void:
	applicants[ability_relay]["accumulated"] = min(40*level, applicants[ability_relay]["accumulated"] + ability_relay.accumulate_damage(damage))
	if not applicants[ability_relay]["bomb_primed"] and ability_relay.owner.alive:
		applicants[ability_relay]["bomb_primed"] = true
		ability_relay.owner.get_node("AnimationPlayer").play("PRIMED")

func before_self_death(modifiers) -> void:
	modifiers["soft_prevented"] = true

func death_effects(ability_relay):
	var explosion_instance = ability_relay.make_projectile(explosion_scene, 
	ability_relay.global_position, ## position
	2, ## inheritance
	Vector2()) ## velocity
	explosion_instance.exclude[ability_relay.owner] = INF
	explosion_instance.scale_multiplier = 8
	get_node("/root/Main/Projectiles").add_child(explosion_instance)
	get_node("/root/Main").play_sound("Explosion")

func damage_dealt_modifiers(_entity, modifiers, ability_relay) -> void:
	if applicants[ability_relay].has("accumulated"):
		modifiers["base"] += 0.5 * applicants[ability_relay]["accumulated"]
