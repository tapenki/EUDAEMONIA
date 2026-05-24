extends Ability

func apply(ability_relay, applicant_data):
	ability_relay.effect_duration_modifiers.connect(effect_duration_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.effect_duration_modifiers.is_connected(effect_duration_modifiers):
		ability_relay.effect_duration_modifiers.disconnect(effect_duration_modifiers)

func effect_duration_modifiers(modifiers) -> void:
	modifiers["base"] += 0.2 * level
