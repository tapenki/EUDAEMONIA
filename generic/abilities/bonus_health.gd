extends Ability

func _ready() -> void:
	if ability_handler.type == "entity":
		ability_handler.max_health_modifiers.connect(max_health_modifiers)
		ability_handler.update_health.emit()

func max_health_modifiers(modifiers) -> void:
	modifiers["source"] += level

func inherit(_handler, _tier):
	return
