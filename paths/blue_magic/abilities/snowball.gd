extends Ability

var inheritance_level = 1

var boost = 1.0

func _ready() -> void:
	if ability_handler.type == "projectile":
		ability_handler.inh_attack_scale_modifiers.connect(attack_scale_modifiers)
		ability_handler.inh_damage_dealt_modifiers.connect(damage_dealt_modifiers)
	else:
		process_mode = ProcessMode.PROCESS_MODE_DISABLED

func _physics_process(delta: float) -> void:
	boost += 0.25 * delta * level * ability_handler.speed_scale

func attack_scale_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= boost

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["multiplier"] *= boost
