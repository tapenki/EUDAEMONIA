extends Ability

var particle_scene = preload("res://paths/statuses/chill/snow.tscn")

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription"):
		return
	if applicants.has(ability_relay):
		applicants[ability_relay]["duration"] += applicant_data["duration"]
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
		ability_relay.speed_scale_modifiers.connect(speed_scale_modifiers)

func disapply(ability_relay):
	for particles in applicants[ability_relay]["particle_instances"]:
		particles.self_death()
	super(ability_relay)
	if ability_relay.speed_scale_modifiers.is_connected(speed_scale_modifiers):
		ability_relay.speed_scale_modifiers.disconnect(speed_scale_modifiers)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants.keys():
		applicants[ability_relay]["duration"] -= delta
		if applicants[ability_relay]["duration"] <= 0:
			disapply(ability_relay)

func speed_scale_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 0.5
