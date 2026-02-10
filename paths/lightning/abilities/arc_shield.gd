extends Ability

func _ready() -> void:
	ability_handler.damage_taken_modifiers.connect(damage_taken_modifiers)

func damage_taken_modifiers(modifiers) -> void:
	if randi() % 5 == 0:
		modifiers["multiplier"] *= 0

func inherit(_handler, _tier):
	return
