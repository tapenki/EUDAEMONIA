extends Ability

var snowball_ii: bool

func apply(ability_relay, applicant_data):
	if not ability_relay.is_projectile:
		return
	if applicants.has(ability_relay.source):
		applicant_data["damage_boost"] = applicants[ability_relay.source]["damage_boost"]
		applicant_data["scale_boost"] = applicants[ability_relay.source]["scale_boost"]
	else:
		applicant_data["damage_boost"] = 0.0
		applicant_data["scale_boost"] = 0.0
	super(ability_relay, applicant_data)
	ability_relay.attack_scale_modifiers.connect(attack_scale_modifiers.bind(ability_relay))
	ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
	ability_relay.crit_chance_modifiers.connect(crit_chance_modifiers.bind(ability_relay))

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.attack_scale_modifiers.is_connected(attack_scale_modifiers):
		ability_relay.attack_scale_modifiers.disconnect(attack_scale_modifiers)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)
	if ability_relay.crit_chance_modifiers.is_connected(crit_chance_modifiers):
		ability_relay.crit_chance_modifiers.disconnect(crit_chance_modifiers)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		applicants[ability_relay]["damage_boost"] += 4 * delta * level * ability_relay.speed_scale
		applicants[ability_relay]["scale_boost"] += (1 - pow(0.5, level)) * delta * ability_relay.speed_scale

func attack_scale_modifiers(modifiers, ability_relay) -> void:
	modifiers["base"] += applicants[ability_relay]["scale_boost"]

func damage_dealt_modifiers(_entity, modifiers, ability_relay) -> void:
	modifiers["base"] += applicants[ability_relay]["damage_boost"]

func crit_chance_modifiers(_entity, modifiers, ability_relay) -> void:
	if not snowball_ii:
		return
	modifiers["base"] += applicants[ability_relay]["damage_boost"]
