extends Ability

var inheritance_level = 3

func _ready() -> void:
	if ability_handler.type == "Entity":
		ability_handler.max_health_modifiers.connect(max_health_modifiers)
		ability_handler.update_health.emit()

func max_health_modifiers(modifiers) -> void:
	modifiers["source"] += 5 * level
