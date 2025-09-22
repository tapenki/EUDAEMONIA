extends Entity

@onready var attack_timer = $AttackTimer

var bullet = preload("res://Entities/Projectiles/Bullet.tscn")

var attacking = false

func _physics_process(_delta):
	var direction: Vector2
	if is_instance_valid(target):
		direction = global_position.direction_to(target.global_position)
		var distance = global_position.distance_to(target.global_position)
		if attacking:
			if attack_timer.is_stopped():
				var fire_rate = ability_handler.get_attack_rate(1)
				attack_timer.start(fire_rate)
				var bullet_instance = ability_handler.make_projectile(bullet, 
				global_position + direction * 25, 
				3,
				direction.rotated(randf_range(-0.05, 0.05)))
				get_node("/root/Main/Projectiles").add_child(bullet_instance)
				ability_handler.attack.emit(direction)
				get_node("/root/Main").play_sound("Pooh")
			if distance < 150:
				animation_player.play("walk")
				direction *= -1
			else:
				animation_player.play("RESET")
				direction = Vector2()
				if distance > 400:
					attacking = false
		else:
			animation_player.play("walk")
			if distance < 250:
				attacking = true
	else:
		animation_player.play("RESET")
		target = ability_handler.find_target()
	var speed = ability_handler.get_move_speed(150)
	velocity = lerp(velocity, direction * speed, 0.2)
	movement()
