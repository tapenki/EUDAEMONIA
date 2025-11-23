extends Ability

func _ready() -> void:
	ability_handler.damage_dealt.connect(damage_dealt)
	
func damage_dealt(entity, damage) -> void:
	if damage.has("first_blood"):
		var doom = ability_handler.apply_status(entity.ability_handler, "doom", level)
		doom.stored_damage += damage["final"]
