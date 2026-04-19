extends Ability

var projectile_scene = preload("res://paths/lightning/ball_lightning.tscn")

var covalence: bool

func apply(ability_relay, applicant_data):
	if ability_relay.owner.scene_file_path == "res://paths/lightning/ball_lightning.tscn":
		applicant_data["ball_power"] = true
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
		ability_relay.crit_chance_modifiers.connect(crit_chance_modifiers)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("ball_power"):
		applicant_data["ball_power"] = applicants[ability_relay.source]["ball_power"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
		ability_relay.crit_chance_modifiers.connect(crit_chance_modifiers)
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 3:
		var anchor_node = Node2D.new()
		ability_relay.add_child(anchor_node)
		applicant_data["anchor_node"] = anchor_node
		var orbit_distance = 150
		if covalence:
			orbit_distance = 90
		var total = 2
		if covalence:
			total = 3
		for repeat in total:
			var projectile_instance = ability_relay.make_projectile(projectile_scene, 
			Vector2.from_angle(TAU / total * repeat) * orbit_distance,
			{"subscription" = 2},
			Vector2())
			projectile_instance.get_node("Sprite").rotation = (Vector2.from_angle(PI * 0.5 + (TAU / total * repeat))).angle()
			projectile_instance.get_node("Sprite/Particles").ability_relay = ability_relay
			anchor_node.add_child(projectile_instance)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	if applicants.has(ability_relay) and applicants[ability_relay].has("anchor_node"):
		for i in applicants[ability_relay]["anchor_node"].get_children():
			i.kill()
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)
	if ability_relay.crit_chance_modifiers.is_connected(crit_chance_modifiers):
		ability_relay.crit_chance_modifiers.disconnect(crit_chance_modifiers)

func _physics_process(delta: float) -> void:
	for applicant in applicants:
		if applicants[applicant].has("anchor_node"):
			applicants[applicant]["anchor_node"].rotation += delta * PI * applicant.speed_scale

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += 5 * level - 5

func crit_chance_modifiers(_entity, modifiers) -> void:
	modifiers["multiplier"] *= 1 + level * 0.2

func apply_covalence():
	covalence = true
	for ability_relay in applicants:
		if applicants[ability_relay].has("anchor_node"):
			for i in applicants[ability_relay]["anchor_node"].get_children():
				i.kill()
			for repeat in 3:
				var projectile_instance = ability_relay.make_projectile(projectile_scene, 
				Vector2.from_angle(TAU / 3 * repeat) * 90,
				{"subscription" = 2},
				Vector2())
				projectile_instance.get_node("Sprite").rotation = (Vector2.from_angle(PI * 0.5 + (TAU / 3 * repeat))).angle()
				projectile_instance.get_node("Sprite/Particles").ability_relay = ability_relay
				applicants[ability_relay]["anchor_node"].add_child(projectile_instance)
