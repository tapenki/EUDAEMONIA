extends Ability

func _ready() -> void:
	if ability_handler.is_projectile:
		ability_handler.inh_speed_scale_modifiers.connect(inh_speed_scale_modifiers)

func inh_speed_scale_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 1.5
