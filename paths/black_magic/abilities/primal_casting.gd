extends Ability

var inheritance_level = 1
var type = "Upgrade"

func _ready() -> void:
	if ability_handler.type == "Entity":
		ability_handler.damage_dealt_modifiers.connect(damage_dealt_modifiers)

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["source"] += ability_handler.owner.max_health * 0.04 * level
