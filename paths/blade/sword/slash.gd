extends Projectile

@onready var lifetime = $Lifetime

func _physics_process(delta):
	super(delta)
	velocity *= 0.9
	if ability_relay.get_hits_left() <= 0:
		velocity *= 0.5

func wall_collision():
	if hit_walls:
		for body in get_overlapping_bodies():
			if body is TileMapLayer:
				velocity *= 0.5
				break

func _on_lifetime_timeout() -> void:
	kill()

func on_hit(crits):
	on_collision(crits)
	if unlimited_hits:
		return
	hits_left -= 1
	if ability_relay.get_hits_left() == 0:
		hit_enabled = false

func adjust_scale():
	var scale_progress = Tween.interpolate_value(0.5, 0.5, lifetime.wait_time-lifetime.time_left, lifetime.wait_time, Tween.TRANS_QUAD, Tween.EASE_OUT)
	scale = Vector2(1, 1) * ability_relay.get_attack_scale() * scale_progress
	var alpha_progress = Tween.interpolate_value(0.0, 1.0, lifetime.wait_time-lifetime.time_left, lifetime.wait_time, Tween.TRANS_QUART, Tween.EASE_IN)
	modulate.a = 1-alpha_progress
