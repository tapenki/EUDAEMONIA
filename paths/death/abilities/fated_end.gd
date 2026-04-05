#extends Ability
#
#func _ready() -> void:
	#ability_relay.damage_dealt.connect(damage_dealt)
	#
#func damage_dealt(entity, damage) -> void:
	#if damage.has("first_blood"):
		#var has_doom = entity.ability_relay.has_node("doom")
		#var doom = ability_relay.apply_status(entity.ability_relay, "doom", level*6)
		#if not has_doom:
			#doom.stored_damage += damage["final"]
