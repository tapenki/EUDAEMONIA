extends Ability

var charge = 0

func _ready() -> void:
	ability_handler.move_speed_modifiers.connect(move_speed_modifiers)
	ability_handler.immune_duration_modifiers.connect(immune_duration_modifiers)

func move_speed_modifiers(modifiers) -> void:
	modifiers["source"] += 50 * level

func immune_duration_modifiers(modifiers) -> void:
	modifiers["source"] += 0.2 * level

func inherit(handler, tier):
	if tier < 3:
		return
	super(handler, tier)
