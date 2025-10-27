extends Ability

var shocking_grasp: bool

func _ready() -> void:
	ability_handler.crit_chance_modifiers.connect(crit_chance_modifiers)
	ability_handler.damage_dealt_modifiers.connect(damage_dealt_modifiers)

func crit_chance_modifiers(entity, modifiers) -> void:
	if entity and (entity.health == entity.max_health or entity.ability_handler.has_node("shock")):
		modifiers["source"] += 25 * level
		if shocking_grasp and entity.health == entity.max_health:
			ability_handler.apply_status(entity.ability_handler, "shock", 1)

func damage_dealt_modifiers(_entity, modifiers, crits) -> void:
	if crits > 0:
		modifiers["source"] += 5 * level
