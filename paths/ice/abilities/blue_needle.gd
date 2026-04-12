extends Ability

func apply(ability_relay, applicant_data):
	if not ability_relay.is_projectile:
		return
	applicant_data["pierce"] = ability_relay.roll_chance({"base": 20 * level, "multiplier": 1.0})
	ability_relay.hits_left_modifiers.connect(hits_left_modifiers.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.hits_left_modifiers.is_connected(hits_left_modifiers):
		ability_relay.hits_left_modifiers.disconnect(hits_left_modifiers)

func hits_left_modifiers(modifiers, ability_relay) -> void:
	modifiers["base"] += applicants[ability_relay]["pierce"]
