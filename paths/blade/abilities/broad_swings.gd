extends Ability

func apply(ability_relay, applicant_data):
	ability_relay.attack_scale_modifiers.connect(attack_scale_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.attack_scale_modifiers.is_connected(attack_scale_modifiers):
		ability_relay.attack_scale_modifiers.disconnect(attack_scale_modifiers)

func attack_scale_modifiers(modifiers) -> void:
	modifiers["base"] += 0.2 * level
