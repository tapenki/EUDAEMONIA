extends Projectile

var windup = 0.0

func _physics_process(delta):
	super(delta)
	windup += delta
	if windup >= hit_delay:
		hit_enabled = true

func _on_lifetime_timeout() -> void:
	kill()
