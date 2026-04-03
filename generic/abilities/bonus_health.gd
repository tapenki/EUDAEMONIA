extends Ability

func _ready() -> void:
	if ability_relay.is_entity:
		ability_relay.max_health_modifiers.connect(max_health_modifiers)

func max_health_modifiers(modifiers) -> void:
	modifiers["base"] += level

func inherit(_handler, _tier):
	return
