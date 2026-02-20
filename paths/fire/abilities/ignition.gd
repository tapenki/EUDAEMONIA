extends Ability

func _ready() -> void:
	ability_handler.damage_dealt.connect(damage_dealt)
	
func damage_dealt(entity, damage) -> void:
	var odds = {"base": 33, "multiplier": 1.0}
	odds["crits"] = damage["crits"]
	if ability_handler.roll_chance(odds):
		ability_handler.apply_status(entity.ability_handler, "burn", level * 3)
