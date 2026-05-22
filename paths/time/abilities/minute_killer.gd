extends Ability

func apply(ability_relay, applicant_data):
	super(ability_relay, applicant_data)
	ability_relay.crit_chance_modifiers.connect(crit_chance_modifiers)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.crit_chance_modifiers.is_connected(crit_chance_modifiers):
		ability_relay.crit_chance_modifiers.disconnect(crit_chance_modifiers)

func crit_chance_modifiers(entity, crits) -> void:
	if not entity:
		return
	if entity.ability_relay.speed_scale < 1 or (ability_handler.has_node("doom") and ability_handler.get_node("doom").applicants.has(entity.ability_relay)):
		crits["base"] += 100
