extends Ability

var snap_freeze: bool

func _ready() -> void:
	ability_relay.damage_dealt.connect(damage_dealt)
	
func damage_dealt(entity, damage) -> void:
	var odds = {"base": 33, "multiplier": 1.0}
	odds["crits"] = damage["crits"]
	if ability_relay.roll_chance(odds):
		ability_relay.apply_status(entity.ability_relay, "chill", level)
	if snap_freeze and damage.has("first_blood"):
		ability_relay.apply_status(entity.ability_relay, "freeze", level * 0.2)
