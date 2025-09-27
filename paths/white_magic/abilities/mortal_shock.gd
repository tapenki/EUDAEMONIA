extends Ability

var inheritance_level = 1

func _ready() -> void:
	ability_handler.crit_chance_modifiers.connect(crit_chance_modifiers)
	ability_handler.damage_dealt_modifiers.connect(damage_dealt_modifiers)

func crit_chance_modifiers(_entity, modifiers) -> void:
	modifiers["source"] += 5 * level

func damage_dealt_modifiers(_entity, modifiers, crits) -> void:
	if crits > 0:
		modifiers["source"] += 8 * level
