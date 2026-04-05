#extends Ability
#
#func _ready() -> void:
	#ability_relay.damage_dealt.connect(damage_dealt)
	#
#func damage_dealt(entity, damage) -> void:
	#var odds = {"base": 33, "multiplier": 1.0}
	#odds["crits"] = damage["crits"]
	#if ability_relay.roll_chance(odds):
		#ability_relay.apply_status(entity.ability_relay, "burn", level * 3)
