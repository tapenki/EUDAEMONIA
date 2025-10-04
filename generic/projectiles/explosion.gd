extends Projectile

@onready var lifetime = $Lifetime
var scale_multiplier = 1

func adjust_scale():
	var scale_progress = Tween.interpolate_value(0.0, 1.0, lifetime.wait_time-lifetime.time_left, lifetime.wait_time, Tween.TRANS_QUART, Tween.EASE_OUT)
	scale = Vector2(1, 1) * ability_handler.get_attack_scale() * scale_multiplier * scale_progress
	var alpha_progress = Tween.interpolate_value(0.0, 1.0, lifetime.wait_time-lifetime.time_left, lifetime.wait_time, Tween.TRANS_QUART, Tween.EASE_IN)
	modulate.a = 1-alpha_progress

func _on_lifetime_timeout() -> void:
	kill()
