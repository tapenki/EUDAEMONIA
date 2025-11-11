extends Ability

var snap_freeze: bool

func _ready() -> void:
	ability_handler.damage_dealt.connect(damage_dealt)
	
func damage_dealt(entity, damage) -> void:
	ability_handler.apply_status(entity.ability_handler, "chill", level)
	if snap_freeze and damage.has("first_blood"):
		ability_handler.apply_status(entity.ability_handler, "freeze", level)
