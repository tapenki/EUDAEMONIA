extends Ability

var particle_scene = preload("res://paths/statuses/doom/doom.tscn")

var swift_fate: bool

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription"):
		return
	if applicants.has(ability_relay):
		applicants[ability_relay]["stacks"] += applicant_data["stacks"]
	else:
		applicant_data["accumulated"] = 0
		applicant_data["duration"] = 4
		var particle_instances: Array
		for sprite in ability_relay.owner.get_sprites():
			var particle_instance = particle_scene.instantiate()
			particle_instance.modulate = Config.get_team_color(1, "secondary")
			particle_instance.position = sprite["offset"]
			particle_instance.emission_rect_extents.x = sprite["size"].x * 0.5
			particle_instance.emission_rect_extents.y = sprite["size"].y * 0.5
			particle_instance.amount = max(particle_instance.amount * sprite["size"].x * sprite["size"].y * 0.0003, 1)
			particle_instances.append(particle_instance)
			sprite["node"].add_child(particle_instance)
		applicant_data["particle_instances"] = particle_instances
		super(ability_relay, applicant_data)
		ability_relay.damage_taken.connect(damage_taken.bind(ability_relay))

func disapply(ability_relay):
	if applicants.has(ability_relay):
		for particles in applicants[ability_relay]["particle_instances"]:
			particles.self_death()
	super(ability_relay)
	if ability_relay.damage_taken.is_connected(damage_taken):
		ability_relay.damage_taken.disconnect(damage_taken)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants.keys():
		if swift_fate:
			applicants[ability_relay]["duration"] -= delta * 2
		else:
			applicants[ability_relay]["duration"] -= delta
		if applicants[ability_relay]["duration"] <= 0:
			var damage_mult = 0.4
			if swift_fate:
				damage_mult = 0.6
			ability_relay.deal_damage(ability_relay.owner, 
			{"base" : damage_mult * applicants[ability_relay]["accumulated"], "multiplier" : 1.0, "flat" : 0, "skip_input_modifiers": true, "skip_output_modifiers": true, "skip_immunity": true},
			Config.get_team_color(1, "secondary"))
			disapply(ability_relay)

func damage_taken(damage, ability_relay) -> void:
	applicants[ability_relay]["accumulated"] = min(10 * applicants[ability_relay]["stacks"], applicants[ability_relay]["accumulated"] + ability_relay.accumulate_damage(damage))
