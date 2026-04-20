extends Ability

var damage_boost = 0.0

func apply(ability_relay, applicant_data):
	if not applicant_data.has("subscription") or applicant_data["subscription"] >= 3:
		applicant_data["damage_boost"] = 0.0
		ability_relay.damage_taken.connect(damage_taken.bind(ability_relay))
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
	elif applicants.has(ability_relay.source) and applicants[ability_relay.source].has("damage_boost"):
		applicant_data["damage_boost"] = applicants[ability_relay.source]["damage_boost"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_taken.is_connected(damage_taken):
		ability_relay.damage_taken.disconnect(damage_taken)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func _ready() -> void:
	get_node("/root/Main").intermission.connect(intermission)

func intermission(_day):
	for ability_relay in applicants:
		applicants[ability_relay]["damage_boost"] = 0.0

func damage_taken(damage, ability_relay) -> void:
	applicants[ability_relay]["damage_boost"] = min(applicants[ability_relay]["damage_boost"] + damage["final"] * 0.1, 4 * level)

func damage_dealt_modifiers(_entity, modifiers, ability_relay) -> void:
	modifiers["base"] += applicants[ability_relay]["damage_boost"]
