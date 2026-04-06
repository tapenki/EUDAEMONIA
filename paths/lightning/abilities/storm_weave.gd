extends Ability

func apply(ability_relay, applicant_data):
	super(ability_relay, applicant_data)
	ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func damage_dealt_modifiers(entity, damage, ability_relay) -> void:
	damage["crits"] += ability_relay.get_crits(entity, {"base" : 0, "multiplier" : 0.1}, damage.has("skip_input_modifiers"), damage.has("skip_output_modifiers"))
