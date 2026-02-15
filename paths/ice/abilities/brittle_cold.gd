extends Ability

func _ready() -> void:
	ability_handler.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	
func damage_dealt_modifiers(entity, damage) -> void:
	if not entity:
		return
	var health_values = entity.ability_handler.get_health()
	if health_values["health"] <= health_values["max_health"] * 0.33:
		damage["multiplier"] *= 3
