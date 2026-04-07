extends Ability

var damage_boost = 0.0

func apply(ability_relay, applicant_data):
	if not applicant_data.has("subscription") or applicant_data["subscription"] >= 3:
		ability_relay.damage_taken.connect(damage_taken)
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	elif applicants.has(ability_relay.source):
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
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
	damage_boost = 0.0

func damage_taken(_damage) -> void:
	damage_boost = min(damage_boost + 0.5 * level, 5 * level)

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += damage_boost
