extends Ability

func _ready() -> void:
	if ability_handler.is_entity:
		ability_handler.heal_modifiers.connect(heal_modifiers)

func heal_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 2

func inherit(handler, tier):
	if tier < 3:
		return
	super(handler, tier)
