extends State

@export var bullet: PackedScene
@export var bullet_lifetime: float
@export var bullet_speed = 600

@export var next: State

func on_enter() -> void:
	super()
	if not is_instance_valid(state_handler.target):
		state_handler.target = user.ability_handler.find_target()
	
	var direction: Vector2
	if is_instance_valid(state_handler.target):
		direction = user.global_position.direction_to(state_handler.target.global_position)
		#var distance = user.global_position.distance_to(state_handler.target.global_position)
		#var fire_rate = user.ability_handler.get_attack_rate(1)
		for i in 10:
			var liferangemult = randf_range(0.2, 1.2)
			var bullet_instance = user.ability_handler.make_projectile(bullet, 
			user.global_position + direction * 25 + Vector2(randf_range(-25, 25), randf_range(-25, 25)), 
			3,
			direction * bullet_speed * liferangemult)
			bullet_instance.get_node("Lifetime").wait_time = bullet_lifetime * liferangemult
			get_node("/root/Main/Projectiles").add_child(bullet_instance)
		#user.ability_handler.attack.emit(direction)
		get_node("/root/Main").play_sound("ShootLight")
	state_handler.target = null
	state_handler.change_state(next)
