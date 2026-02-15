extends Ability

func _ready() -> void:
	if ability_handler.owner is Player:
		return
	ability_handler.damage_dealt.connect(damage_dealt)
	
func damage_dealt(entity, _damage) -> void:
	ability_handler.apply_status(entity.ability_handler, "freeze", 1.5)

func inherit(handler, tier):
	if handler.owner.scene_file_path != "res://paths/ice/cryobomb/cryobomb.tscn" and ability_handler.owner.scene_file_path != "res://paths/ice/cryobomb/cryobomb.tscn":
		return
	super(handler, tier)
