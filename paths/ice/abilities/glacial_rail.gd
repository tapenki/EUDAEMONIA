extends Ability

func _ready() -> void:
	if ability_relay.is_projectile:
		ability_relay.speed_scale_modifiers.connect(speed_scale_modifiers)

func speed_scale_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 1.5
