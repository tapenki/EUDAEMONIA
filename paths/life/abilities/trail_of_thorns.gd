extends Ability

var bullet = preload("res://paths/life/spike/spike.tscn")

var pain_walk: bool

func apply(ability_relay, applicant_data):
	if ability_relay.owner.scene_file_path == "res://paths/life/spike/spike.tscn":
		applicant_data["thorn_power"] = true
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("thorn_power"):
		applicant_data["thorn_power"] = applicants[ability_relay.source]["thorn_power"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 3:
		applicant_data["charge"] = 0
		applicant_data["pain_walk"] = 0
		ability_relay.movement.connect(movement.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.movement.is_connected(movement):
		ability_relay.movement.disconnect(movement)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func spawn(spawn_position, ability_relay):
	var bullet_instance = ability_relay.make_projectile(bullet, 
	spawn_position, 
	{"subscription" = 2},
	Vector2())
	get_node("/root/Main/Projectiles").add_child(bullet_instance)

func movement(distance, ability_relay) -> void:
	if not applicants[ability_relay].has("charge"):
		return
	applicants[ability_relay]["charge"] += distance
	if applicants[ability_relay]["charge"] >= 100:
		applicants[ability_relay]["charge"] -= 100
		if pain_walk:
			for i in 2:
				spawn(ability_relay.owner.global_position + Vector2(randf_range(-24, 24), randf_range(-24, 24)), ability_relay)
			if ability_relay.is_entity:
				applicants[ability_relay]["pain_walk"] = (applicants[ability_relay]["pain_walk"] + 1) % 2
				if applicants[ability_relay]["pain_walk"] == 0:
					var max_health = ability_relay.get_health()["max_health"]
					ability_relay.deal_damage(ability_relay.owner, {"base" : 0.02 * max_health, "multiplier" : 1.0, "flat" : 0, "skip_input_modifiers": true, "skip_output_modifiers": true, "skip_immunity": true}, Config.get_team_color(1, "tertiary"))
		else:
			spawn(ability_relay.owner.global_position, ability_relay)

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += 5 * level - 5
