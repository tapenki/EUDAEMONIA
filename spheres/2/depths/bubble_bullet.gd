extends Projectile

func _physics_process(delta):
	super(delta)
	velocity *= 0.99
