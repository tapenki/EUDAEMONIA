extends Ability

var snap_freeze: bool

func _ready() -> void:
	ability_handler.damage_dealt.connect(damage_dealt)
	
func damage_dealt(entity, damage) -> void:
	var odds = {"base": 33, "multiplier": 1.0}
	odds["crits"] = damage["crits"]
	if ability_handler.roll_chance(odds):
		ability_handler.apply_status(entity.ability_handler, "chill", level * 0.75)
	if snap_freeze and damage.has("first_blood"):
		ability_handler.apply_status(entity.ability_handler, "freeze", level * 0.15)
