extends Ability

var particle_scene = preload("res://paths/lightning/shock.tscn")

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription"):
		return
	applicant_data["duration"] = 4
	if applicants.has(ability_relay):
		applicants[ability_relay]["duration"] = applicant_data["duration"]
	else:
		var particle_instances: Array
		for sprite in ability_relay.owner.get_sprites():
			var particle_instance = particle_scene.instantiate()
			particle_instance.modulate = Config.get_team_color(1, "secondary")
			particle_instance.position = sprite["offset"]
			particle_instance.emission_rect_extents.x = sprite["size"].x * 0.5
			particle_instance.emission_rect_extents.y = sprite["size"].y * 0.5
			particle_instance.amount = max(particle_instance.amount * sprite["size"].x * sprite["size"].y * 0.0005, 1)
			particle_instances.append(particle_instance)
			sprite["node"].add_child(particle_instance)
		applicant_data["particle_instances"] = particle_instances
		super(ability_relay, applicant_data)
		ability_relay.crit_taken_modifiers.connect(crit_taken_modifiers.bind(ability_relay))

func disapply(ability_relay):
	for particles in applicants[ability_relay]["particle_instances"]:
		particles.self_death()
	super(ability_relay)
	if ability_relay.crit_taken_modifiers.is_connected(crit_taken_modifiers):
		ability_relay.crit_taken_modifiers.disconnect(crit_taken_modifiers)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants.keys():
		applicants[ability_relay]["duration"] -= delta
		if applicants[ability_relay]["duration"] <= 0:
			disapply(ability_relay)

func crit_taken_modifiers(modifiers, ability_relay) -> void:
	modifiers["base"] += applicants[ability_relay]["stacks"]
