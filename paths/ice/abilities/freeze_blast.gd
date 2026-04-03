extends Ability

func _ready() -> void:
	if ability_relay.owner is Player:
		return
	ability_relay.damage_dealt.connect(damage_dealt)
	
func damage_dealt(entity, _damage) -> void:
	ability_relay.apply_status(entity.ability_relay, "freeze", 1.5)

func inherit(handler, tier):
	if handler.owner.scene_file_path != "res://paths/ice/cryobomb/cryobomb.tscn" and ability_relay.owner.scene_file_path != "res://paths/ice/cryobomb/cryobomb.tscn":
		return
	super(handler, tier)
