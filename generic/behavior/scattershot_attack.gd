extends State

@export var bullet: PackedScene
@export var bullet_lifetime: float
@export var bullet_count: int
@export var spread: int
@export var bullet_speed = 600

@export var next: State

func on_enter() -> void:
	super()
	if not is_instance_valid(state_handler.target):
		state_handler.target = user.ability_handler.find_target()
	
	var direction: Vector2
	if is_instance_valid(state_handler.target):
		direction = user.global_position.direction_to(state_handler.target.global_position)
		var stepsize = deg_to_rad(spread) / (bullet_count - 1)
		var halfspan = deg_to_rad(spread) * 0.5
		for i in bullet_count:
			var bullet_instance = user.ability_handler.make_projectile(bullet, 
			user.global_position + direction * 25, 
			3,
			direction.rotated(halfspan - (stepsize * i)) * bullet_speed)
			bullet_instance.get_node("Lifetime").wait_time = bullet_lifetime
			get_node("/root/Main/Projectiles").add_child(bullet_instance)
		#user.ability_handler.attack.emit(direction)
		get_node("/root/Main").play_sound("Pooh")
	state_handler.target = null
	state_handler.change_state(next)
