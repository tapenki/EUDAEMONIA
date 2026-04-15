extends State

@export var bullet: PackedScene
@export var bullet_lifetime: float
@export var bullet_count: int
@export var spread: int
@export var bullet_speed = 600

@export var recalc_direction = true
#@export var prediction = 0.3

@export var next: State

func on_enter() -> void:
	super()
	if recalc_direction:
		if not is_instance_valid(state_handler.target):
			state_handler.target = user.ability_relay.find_target()
		if not is_instance_valid(state_handler.target):
			state_handler.change_state(next)
			return
		#var time_to_hit = user.global_position.distance_to(state_handler.target.global_position) / bullet_speed
		#var predicted_position = state_handler.target.global_position + state_handler.target.velocity * prediction * time_to_hit
		state_handler.data["direction"] = user.global_position.direction_to(state_handler.target.global_position)#user.global_position.direction_to(predicted_position)
	
	var direction = state_handler.data["direction"]
	var stepsize = deg_to_rad(spread) / (bullet_count - 1)
	var halfspan = deg_to_rad(spread) * 0.5
	for i in bullet_count:
		var bullet_instance = user.ability_relay.make_projectile(bullet, 
		user.global_position + direction * 25, 
		{"subscription" = 2},
		direction.rotated(halfspan - (stepsize * i)) * bullet_speed)
		bullet_instance.get_node("Lifetime").wait_time = bullet_lifetime
		get_node("/root/Main/Projectiles").add_child(bullet_instance)
	#user.ability_relay.attack.emit(direction)
	get_node("/root/Main").play_sound("ShootLight")
	state_handler.target = null
	state_handler.change_state(next)
