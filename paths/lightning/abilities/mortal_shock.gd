extends Ability

func apply(ability_relay, applicant_data):
	super(ability_relay, applicant_data)
	ability_relay.crit_chance_modifiers.connect(crit_chance_modifiers)
	ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.crit_chance_modifiers.is_connected(crit_chance_modifiers):
		ability_relay.crit_chance_modifiers.disconnect(crit_chance_modifiers)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func crit_chance_modifiers(entity, modifiers) -> void:
	if entity and (entity.health == entity.max_health or entity.ability_relay.has_node("shock")):
		modifiers["base"] += 20 * level

func damage_dealt_modifiers(_entity, modifiers) -> void:
	if modifiers.get("crits", 0) > 0:
		modifiers["base"] += 2 * level
