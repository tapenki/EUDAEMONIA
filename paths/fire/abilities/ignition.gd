extends Ability

func _ready() -> void:
	ability_handler.damage_dealt.connect(damage_dealt)
	
func damage_dealt(entity, _damage) -> void:
	ability_handler.apply_status(entity.ability_handler, "burn", level * 2)
