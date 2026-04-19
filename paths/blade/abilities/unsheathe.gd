extends Ability

func apply(ability_relay, applicant_data):
	if applicant_data.has("sword"):
		if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("unsheathe_charge"):
			applicant_data["unsheathe_multiplier"] = applicants[ability_relay.source]["unsheathe_charge"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("unsheathe_multiplier"):
		applicant_data["unsheathe_multiplier"] = applicants[ability_relay.source]["unsheathe_multiplier"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 3:
		applicant_data["unsheathe_charge"] = 0.0
		ability_relay.attack_success.connect(attack_success.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("unsheathe_charge"):
			if applicants[ability_relay]["unsheathe_charge"] < 4:
				applicants[ability_relay]["unsheathe_charge"] = min(4.0, applicants[ability_relay]["unsheathe_charge"] + delta * ability_relay.speed_scale)
				if applicants[ability_relay]["unsheathe_charge"] == 4:
					get_node("/root/Main/ParticleHandler").quick_particles("impact", 
					preload("res://generic/particles/star.png"),
					ability_relay.global_position,
					3,
					4,
					Config.get_team_color(ability_relay.owner.group, "secondary"))
					get_node("/root/Main").play_sound("Click")

func attack_success(_direction, weapon, ability_relay) -> void:
	if weapon.name == "sword" and applicants[ability_relay].has("unsheathe_charge"):
		applicants[ability_relay]["unsheathe_charge"] = 0.0

func damage_dealt_modifiers(_entity, modifiers, ability_relay) -> void:
	if applicants[ability_relay].has("unsheathe_multiplier"):
		modifiers["base"] += applicants[ability_relay]["unsheathe_multiplier"] * 5 * level
