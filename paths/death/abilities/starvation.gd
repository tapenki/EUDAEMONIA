extends Ability

func get_hunger_level():
	var hunger = ability_handler.get_node_or_null("hunger")
	if hunger:
		return hunger.level
	return 1

func apply(ability_relay, applicant_data):
	applicant_data["damage_boost"] = 0.0
	if applicants.has(ability_relay.source):
		applicant_data["damage_boost"] = applicants[ability_relay.source]["damage_boost"]
	ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)

func entity_death(_dying_entity: Entity):
	for ability_relay in applicants:
		if ability_relay.is_entity and ability_relay.owner.summoned:
			applicants[ability_relay]["damage_boost"] += 0.4 * get_hunger_level()

func damage_dealt_modifiers(_entity, modifiers, ability_relay) -> void:
	modifiers["base"] += applicants[ability_relay]["damage_boost"]
