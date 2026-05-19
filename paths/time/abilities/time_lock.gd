extends Ability

func apply(ability_relay, applicant_data):
	ability_relay.knockback_taken_modifiers.connect(knockback_taken_modifiers)
	ability_relay.slow_taken_modifiers.connect(knockback_taken_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.knockback_taken_modifiers.is_connected(knockback_taken_modifiers):
		ability_relay.knockback_taken_modifiers.disconnect(knockback_taken_modifiers)
	if ability_relay.slow_taken_modifiers.is_connected(slow_taken_modifiers):
		ability_relay.slow_taken_modifiers.disconnect(slow_taken_modifiers)

func knockback_taken_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 0

func slow_taken_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 0
