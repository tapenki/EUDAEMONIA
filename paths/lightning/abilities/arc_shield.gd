extends Ability

func _ready() -> void:
	ability_handler.damage_taken_modifiers.connect(damage_taken_modifiers)

func damage_taken_modifiers(damage) -> void:
	var odds = {"base": 20, "multiplier": 1.0}
	odds["crits"] = damage["crits"]
	if ability_handler.roll_chance(odds):
		damage["multiplier"] *= 0

func inherit(handler, tier):
	if tier < 3:
		return
	super(handler, tier)
