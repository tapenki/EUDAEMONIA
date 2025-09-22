extends Ability

var inheritance_level = 1
var type = "Upgrade"

var chill_script = preload("res://generic/abilities/status/chill.gd")

func _ready() -> void:
	ability_handler.damage_dealt.connect(damage_dealt)
	
func damage_dealt(entity, _damage, _crits) -> void:
	ability_handler.apply_status(entity.ability_handler, chill_script, "chill", level)
