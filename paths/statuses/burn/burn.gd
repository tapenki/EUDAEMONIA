extends Ability

var particle_scene = preload("res://paths/statuses/burn/burn.tscn")

var pyre: bool

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription"):
		return
	if applicants.has(ability_relay):
		applicants[ability_relay]["stacks"] += applicant_data["stacks"]
		applicants[ability_relay]["ticks"] = 0
	else:
		applicant_data["duration"] = 1
		applicant_data["ticks"] = 0
		var particle_instances: Array
		for sprite in ability_relay.owner.get_sprites():
			var particle_instance = particle_scene.instantiate()
			particle_instance.modulate = Config.get_team_color(1, "secondary")
			particle_instance.position = sprite["offset"]
			particle_instance.emission_rect_extents.x = sprite["size"].x * 0.5
			particle_instance.emission_rect_extents.y = sprite["size"].y * 0.5
			particle_instance.amount = max(particle_instance.amount * sprite["size"].x * sprite["size"].y * 0.0002, 1)
			particle_instances.append(particle_instance)
			sprite["node"].add_child(particle_instance)
		applicant_data["particle_instances"] = particle_instances
		super(ability_relay, applicant_data)

func disapply(ability_relay):
	for particles in applicants[ability_relay]["particle_instances"]:
		particles.self_death()
	super(ability_relay)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants.keys():
		var max_ticks = 4
		if pyre:
			max_ticks = 8
		if applicants[ability_relay]["ticks"] >= max_ticks:
			disapply(ability_relay)
		else:
			applicants[ability_relay]["duration"] -= delta
			if applicants[ability_relay]["duration"] <= 0:
				ability_relay.deal_damage(ability_relay.owner, 
				{"base" : applicants[ability_relay]["stacks"], "multiplier" : 1.0, "skip_input_modifiers": true, "skip_output_modifiers": true, "skip_immunity": true},
				Config.get_team_color(1, "secondary"))
				applicants[ability_relay]["duration"] = 1
				applicants[ability_relay]["ticks"] += 1
