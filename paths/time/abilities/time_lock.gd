extends Ability

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 3:
		ability_relay.knockback_taken_modifiers.connect(knockback_taken_modifiers)
		ability_relay.incoming_slow_modifiers.connect(incoming_slow_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.knockback_taken_modifiers.is_connected(knockback_taken_modifiers):
		ability_relay.knockback_taken_modifiers.disconnect(knockback_taken_modifiers)
	if ability_relay.incoming_slow_modifiers.is_connected(incoming_slow_modifiers):
		ability_relay.incoming_slow_modifiers.disconnect(incoming_slow_modifiers)

func knockback_taken_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 0

func incoming_slow_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 0
