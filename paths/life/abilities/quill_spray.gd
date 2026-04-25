extends Ability

var quills_scene = preload("res://paths/life/quills/quills.tscn")

var pressurized_quills: bool

func apply(ability_relay, applicant_data):
	if ability_relay.owner.scene_file_path == "res://paths/life/quills/quills.tscn":
		if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("pressure_multiplier"):
			applicant_data["quill_spray"] = applicants[ability_relay.source]["pressure_multiplier"]
		else:
			applicant_data["quill_spray"] = 1.0
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
		ability_relay.attack_scale_modifiers.connect(attack_scale_modifiers)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("quill_spray"):
		applicant_data["quill_spray"] = applicants[ability_relay.source]["quill_spray"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
		ability_relay.attack_scale_modifiers.connect(attack_scale_modifiers)
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 3:
		applicant_data["pressure_multiplier"] = 1.0
		ability_relay.damage_taken.connect(damage_taken.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_taken.is_connected(damage_taken):
		ability_relay.damage_taken.disconnect(damage_taken)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)
	if ability_relay.attack_scale_modifiers.is_connected(attack_scale_modifiers):
		ability_relay.attack_scale_modifiers.disconnect(attack_scale_modifiers)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("pressure_multiplier") and pressurized_quills:
			applicants[ability_relay]["pressure_multiplier"] = min(2.0, applicants[ability_relay]["pressure_multiplier"] + 0.2 * delta * ability_relay.speed_scale)

func spawn(position, ability_relay):
	var quills_instance = ability_relay.make_projectile(quills_scene, 
	position, 
	{"subscription" = 2},
	Vector2())
	quills_instance.get_node("Sprite").emitting = true
	get_node("/root/Main/Projectiles").add_child(quills_instance)
	applicants[ability_relay]["pressure_multiplier"] = 1.0

func damage_taken(_damage, ability_relay) -> void:
	call_deferred("spawn", ability_relay.global_position, ability_relay)

func damage_dealt_modifiers(_entity, modifiers, ability_relay) -> void:
	modifiers["base"] += 5 * level
	if applicants[ability_relay].has("quill_spray"):
		modifiers["multiplier"] *= applicants[ability_relay]["quill_spray"]

func attack_scale_modifiers(modifiers) -> void:
	modifiers["base"] += 0.4 * level - 0.4
