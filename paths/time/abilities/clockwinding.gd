extends Ability

func apply(ability_relay, applicant_data):
	ability_relay.attack_rate_modifiers.connect(attack_rate_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.attack_rate_modifiers.is_connected(attack_rate_modifiers):
		ability_relay.attack_rate_modifiers.disconnect(attack_rate_modifiers)

func attack_rate_modifiers(modifiers) -> void:
	modifiers["base"] += 0.1 * level
