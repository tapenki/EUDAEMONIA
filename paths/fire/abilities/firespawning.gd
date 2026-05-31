extends Ability

var summon = preload("res://paths/fire/flaming_skull/flaming_skull.tscn")

var status: Node

var vengeful_flames: bool

func apply(ability_relay, applicant_data):
	if applicant_data.has("firespawning"):
		ability_relay.max_health_modifiers.connect(max_health_modifiers)
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
		ability_relay.death_effects.connect(death_effects.bind(ability_relay))
	elif applicants.has(ability_relay.source) and applicants[ability_relay.source].has("firespawning"):
		applicant_data["firespawning"] = applicants[ability_relay.source]["firespawning"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.max_health_modifiers.is_connected(max_health_modifiers):
		ability_relay.max_health_modifiers.disconnect(max_health_modifiers)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)
	if ability_relay.death_effects.is_connected(death_effects):
		ability_relay.death_effects.disconnect(death_effects)

func _ready() -> void:
	status = ability_handler.learn("burn", 0)
	get_node("/root/Main").entity_manifestation.connect(entity_manifestation)

func spawn(spawn_position: Vector2, ability_relay, vengeful_flames_revive = false):
	var delay = 0.5
	var applicant_data = {"subscription" = 2, "firespawning" = true}
	if vengeful_flames_revive:
		delay = 1
		applicant_data["vengeful_flames"] = true
	var summon_instance = ability_relay.make_summon(summon, 
	spawn_position,
	applicant_data)  ## inheritance
	get_node("/root/Main").spawn_entity(summon_instance, delay)

func entity_manifestation(entity: Entity):
	if entity.summoned:
		return
	for ability_relay in applicants:
		if applicants[ability_relay].has("subscription") and applicants[ability_relay]["subscription"] < 5:
			return
		var tilemap = get_node("/root/Main").get_tilemap()
		#for i in 2:
		var cell = get_node("/root/Main").valid_spawn_cells.keys().pick_random()
		var spawn_position = Vector2(cell * tilemap.tile_set.tile_size) + tilemap.tile_set.tile_size * 0.5
		spawn(spawn_position, ability_relay)

func death_effects(ability_relay):
	var attack_scale = ability_relay.get_effect_scale()
	var reach = 150 * attack_scale
	for entity in ability_relay.area_targets(ability_relay.global_position, reach):
		status.apply(entity.ability_relay, {"stacks" = level, "duration" = ability_relay.get_effect_duration()})
		get_node("/root/Main/ParticleHandler").particle_beam("common", 
		preload("res://paths/fire/flame.png"),
		ability_relay.global_position,
		entity.global_position,
		1.0,
		32,
		Config.get_team_color(ability_relay.owner.group, "secondary"))
	if vengeful_flames and applicants.has(ability_relay) and not applicants[ability_relay].has("vengeful_flames"):
		spawn(ability_relay.global_position, ability_relay, true)

func max_health_modifiers(modifiers) -> void:
	modifiers["base"] += 15 * level

func damage_dealt_modifiers(_entity, damage) -> void:
	damage["base"] += 2 * level
