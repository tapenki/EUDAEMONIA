extends Projectile

var windup = 0.0

func _physics_process(delta):
	super(delta)
	windup += delta
	if windup >= hit_delay:
		hit_enabled = true

func calculate_movement(delta):
	return global_position + velocity * delta * ability_relay.speed_scale * 0.33

func _on_lifetime_timeout() -> void:
	kill()
