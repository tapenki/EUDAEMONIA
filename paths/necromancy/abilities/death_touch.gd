extends Ability

func _ready() -> void:
	ability_handler.damage_dealt_modifiers.connect(damage_dealt_modifiers)

func damage_dealt_modifiers(_entity, modifiers, _crits) -> void:
	if randf_range(0, 100) < level:
		modifiers["multiplier"] *= 100
