extends Ability

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 5:
		return
	super(ability_relay, applicant_data)
	ability_relay.max_health_modifiers.connect(max_health_modifiers)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.max_health_modifiers.is_connected(max_health_modifiers):
		ability_relay.max_health_modifiers.disconnect(max_health_modifiers)

func max_health_modifiers(modifiers) -> void:
	modifiers["base"] += level
