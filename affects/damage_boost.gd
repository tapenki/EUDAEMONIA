extends Ability

func apply(ability_relay, applicant_data):
	super(ability_relay, applicant_data)
	ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += level
