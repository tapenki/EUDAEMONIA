extends Ability

var inheritance_level = 1
var type = "Upgrade"

func _ready() -> void:
	ability_handler.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if !ability_handler.is_projectile:
		ability_handler.inh_attack_scale_modifiers.connect(attack_scale_modifiers)

func attack_scale_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 1 + (0.2*level)

func damage_dealt_modifiers(_entity, modifiers) -> void:
	var attack_scale = ability_handler.get_attack_scale()
	modifiers["multiplier"] *= (attack_scale - 1) * 0.1 * level + 1
