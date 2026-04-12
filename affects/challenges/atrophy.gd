extends Ability

func apply(ability_relay, applicant_data):
	if applicants.has(ability_relay.source):
		applicant_data["damage_mult"] = applicants[ability_relay.source]["damage_mult"]
	else:
		applicant_data["damage_mult"] = 0.0
	super(ability_relay, applicant_data)
	ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func _ready() -> void:
	get_node("/root/Main").intermission.connect(intermission)

func intermission(_day):
	for ability_relay in applicants:
		applicants[ability_relay]["damage_mult"] = 0.0

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		applicants[ability_relay]["damage_mult"] = min(1.0, applicants[ability_relay]["damage_mult"] + delta * 0.1 * ability_relay.speed_scale)

func damage_dealt_modifiers(_entity, modifiers, ability_relay) -> void:
	modifiers["multiplier"] *= applicants[ability_relay]["damage_mult"]
