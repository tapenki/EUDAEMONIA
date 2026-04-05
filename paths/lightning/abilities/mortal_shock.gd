#extends Ability
#
#var shocking_grasp: bool
#
#func _ready() -> void:
	#ability_relay.crit_chance_modifiers.connect(crit_chance_modifiers)
	#ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
#
#func crit_chance_modifiers(entity, modifiers) -> void:
	#if entity and (entity.health == entity.max_health or entity.ability_relay.has_node("shock")):
		#modifiers["base"] += 25 * level
		#if shocking_grasp and entity.health == entity.max_health:
			#ability_relay.apply_status(entity.ability_relay, "shock", 1)
#
#func damage_dealt_modifiers(_entity, modifiers) -> void:
	#if modifiers.get("crits", 0) > 0:
		#modifiers["base"] += 5 * level
