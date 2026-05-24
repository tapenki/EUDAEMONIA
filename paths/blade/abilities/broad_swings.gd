extends Ability

func apply(ability_relay, applicant_data):
	ability_relay.effect_scale_modifiers.connect(effect_scale_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.effect_scale_modifiers.is_connected(effect_scale_modifiers):
		ability_relay.effect_scale_modifiers.disconnect(effect_scale_modifiers)

func effect_scale_modifiers(modifiers) -> void:
	modifiers["base"] += 0.2 * level
