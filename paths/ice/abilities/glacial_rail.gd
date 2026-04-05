extends Ability

func apply(ability_relay, applicant_data):
	if not ability_relay.is_projectile:
		return
	super(ability_relay, applicant_data)
	ability_relay.speed_scale_modifiers.connect(speed_scale_modifiers)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.speed_scale_modifiers.is_connected(speed_scale_modifiers):
		ability_relay.speed_scale_modifiers.disconnect(speed_scale_modifiers)

func speed_scale_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 1.5
