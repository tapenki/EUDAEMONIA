extends Ability

func _ready() -> void:
	ability_handler.crit_chance_modifiers.connect(crit_chance_modifiers)
	
func crit_chance_modifiers(entity, crits) -> void:
	if not entity:
		return
	var health_values = entity.ability_handler.get_health()
	if health_values["health"] <= health_values["max_health"] * 0.33:
		crits["base"] += 100
