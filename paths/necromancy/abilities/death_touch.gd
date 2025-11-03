extends Ability

func _ready() -> void:
	ability_handler.damage_dealt_modifiers.connect(damage_dealt_modifiers)

func damage_dealt_modifiers(entity, modifiers) -> void:
	if randf_range(0, 100) < level:
		modifiers["multiplier"] *= 100
