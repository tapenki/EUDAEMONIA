extends Ability

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 3:
		return
	super(ability_relay, applicant_data)
	ability_relay.move_speed_modifiers.connect(move_speed_modifiers)
	ability_relay.immune_duration_modifiers.connect(immune_duration_modifiers)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.move_speed_modifiers.is_connected(move_speed_modifiers):
		ability_relay.move_speed_modifiers.disconnect(move_speed_modifiers)
	if ability_relay.immune_duration_modifiers.is_connected(immune_duration_modifiers):
		ability_relay.immune_duration_modifiers.disconnect(immune_duration_modifiers)

func move_speed_modifiers(modifiers) -> void:
	modifiers["base"] += 40 * level

func immune_duration_modifiers(modifiers) -> void:
	modifiers["base"] += 0.25 * level
