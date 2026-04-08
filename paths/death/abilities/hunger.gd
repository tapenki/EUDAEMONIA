extends Ability

func apply(ability_relay, applicant_data):
	if ability_relay.is_entity and ability_relay.owner.summoned:
		ability_relay.max_health_modifiers.connect(max_health_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.max_health_modifiers.is_connected(max_health_modifiers):
		ability_relay.max_health_modifiers.disconnect(max_health_modifiers)

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)

func entity_death(_dying_entity: Entity):
	for ability_relay in applicants:
		if ability_relay.is_entity and ability_relay.owner.summoned:
			ability_relay.owner.heal(20*level)

func max_health_modifiers(modifiers) -> void:
	modifiers["base"] += 20 * level
