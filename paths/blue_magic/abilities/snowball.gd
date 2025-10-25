extends Ability

var inheritance_level = 1

var damage_boost = 1.0
var scale_boost = 1.0

func _ready() -> void:
	if ability_handler.type == "projectile":
		ability_handler.inh_attack_scale_modifiers.connect(attack_scale_modifiers)
		ability_handler.inh_damage_dealt_modifiers.connect(damage_dealt_modifiers)
	else:
		process_mode = ProcessMode.PROCESS_MODE_DISABLED

func _physics_process(delta: float) -> void:
	damage_boost += 0.5 * delta * level * ability_handler.speed_scale
	scale_boost += (1 - pow(0.5, level)) * delta * ability_handler.speed_scale

func attack_scale_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= scale_boost

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["multiplier"] *= damage_boost
