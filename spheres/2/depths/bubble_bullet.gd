extends Projectile

func _physics_process(delta):
	super(delta)
	velocity *= pow(0.5, delta * ability_relay.speed_scale)
