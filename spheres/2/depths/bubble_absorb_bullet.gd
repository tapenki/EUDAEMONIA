extends Projectile

var target: Entity
var age = 0

func _physics_process(delta):
	super(delta)
	age += delta
	if is_instance_valid(target):
		if global_position.distance_to(target.global_position) < 25:
			#on_collision(0)
			if hit_sound:
				get_node("/root/Main").play_sound(hit_sound)
			kill()
			return
		var to_target = global_position.direction_to(target.global_position) * 450
		velocity = lerp(velocity, to_target, 0.05)
		get_node("Lifetime").start(randf_range(0.2, 0.5))
	else:
		velocity *= 0.9

func entity_collision():
	if age < 0.75:
		return
	super()
