extends Ability

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 3:
		return
	super(ability_relay, applicant_data)
	ability_relay.heal_modifiers.connect(heal_modifiers)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.heal_modifiers.is_connected(heal_modifiers):
		ability_relay.heal_modifiers.disconnect(heal_modifiers)
		
func heal_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 2
