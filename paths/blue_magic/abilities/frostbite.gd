extends Ability

var inheritance_level = 1

var snap_freeze: bool

func _ready() -> void:
	if ability_handler.has_node("snap_freeze"):
		snap_freeze = true
	ability_handler.damage_dealt.connect(damage_dealt)
	
func damage_dealt(entity, _damage, _crits) -> void:
	ability_handler.apply_status(entity.ability_handler, "chill", level)
	if snap_freeze and entity and entity.health == entity.max_health:
		ability_handler.apply_status(entity.ability_handler, "freeze", level)
