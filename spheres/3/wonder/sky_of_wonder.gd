extends Ability

func apply(ability_relay, applicant_data):
	if not applicant_data.has("subscription") or applicant_data["subscription"] >= 5:
		ability_relay.max_health_modifiers.connect(max_health_modifiers)
	ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.max_health_modifiers.is_connected(max_health_modifiers):
		ability_relay.max_health_modifiers.disconnect(max_health_modifiers)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func max_health_modifiers(modifiers) -> void:
	modifiers["base"] += 5 * get_node("/root/Main/UI").upgrade_points

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += get_node("/root/Main/UI").upgrade_points
