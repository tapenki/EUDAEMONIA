extends Ability

var summon = preload("res://paths/fire/flaming_skull/flaming_skull.tscn")

var status: Node

var undying_flames: bool

func apply(ability_relay, applicant_data):
	if applicant_data.has("firespawning"):
		ability_relay.max_health_modifiers.connect(max_health_modifiers)
		ability_relay.death_effects.connect(death_effects.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.max_health_modifiers.is_connected(max_health_modifiers):
		ability_relay.max_health_modifiers.disconnect(max_health_modifiers)
	if ability_relay.death_effects.is_connected(death_effects):
		ability_relay.death_effects.disconnect(death_effects)

func _ready() -> void:
	status = ability_handler.learn("burn", 0)
	get_node("/root/Main").day_start.connect(day_start)

func spawn(spawn_position: Vector2, ability_relay, delay = 0.5):
	var summon_instance = ability_relay.make_summon(summon, 
	spawn_position,
	{"subscription" = 2, "firespawning" = true})  ## inheritance
	get_node("/root/Main").spawn_entity(summon_instance, delay)

func day_start(_day: int) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("subscription") and applicants[ability_relay]["subscription"] < 5:
			return
		var tilemap = get_node("/root/Main").room_node.get_node("TileMap")
		var wall_cells = tilemap.get_used_cells_by_id(0)
		var floor_cells = tilemap.get_used_cells_by_id(2)
		for j in wall_cells:
			for k in range(-1, 2):
				for l in range(-1, 2):
					floor_cells.erase(Vector2i(j.x + k, j.y + l))
		for i in 2:
			var cell = floor_cells.pick_random()
			var spawn_position = Vector2(cell * tilemap.tile_set.tile_size) + tilemap.tile_set.tile_size * 0.5
			spawn(spawn_position, ability_relay)

func death_effects(ability_relay):
	var attack_scale = ability_relay.get_attack_scale({"base" : 0, "multiplier" : 1})
	var reach = 150 * attack_scale
	for entity in ability_relay.area_targets(ability_relay.global_position, reach):
		status.apply(entity.ability_relay, {"stacks" = 4 * level})
		get_node("/root/Main/ParticleHandler").particle_beam("common", 
		preload("res://paths/fire/flame.png"),
		ability_relay.global_position,
		entity.global_position,
		1.0,
		32,
		Config.get_team_color(ability_relay.owner.group, "secondary"))
	if undying_flames:
		for applicant in applicants:
			if applicants[applicant].has("subscription") and applicants[applicant]["subscription"] < 5:
				continue
			applicant.deal_damage(applicant.owner, {"base" : 0.3 * get_node("/root/Main").day + 3, "multiplier" : 1.0, "skip_input_modifiers": true, "skip_output_modifiers": true, "skip_immunity": true}, Config.get_team_color(1, "tertiary"))
		spawn(ability_relay.global_position, ability_relay, 1)

func max_health_modifiers(modifiers) -> void:
	modifiers["base"] += 40 * level
