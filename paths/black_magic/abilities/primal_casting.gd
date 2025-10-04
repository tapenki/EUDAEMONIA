extends Ability

var inheritance_level = 1
var type = "Upgrade"

func _ready() -> void:
	if ability_handler.type == "entity":
		ability_handler.inh_damage_dealt_modifiers.connect(damage_dealt_modifiers)

func damage_dealt_modifiers(_entity, modifiers) -> void:
	var health_values = ability_handler.get_health(ability_handler.owner.health, ability_handler.owner.max_health)
	modifiers["source"] += health_values["max_health"] * 0.04 * level
