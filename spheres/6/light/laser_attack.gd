extends State

@export var laser: PackedScene
@export var bullet_lifetime: float
@export var bullet_speed = 600

@export var recalc_direction = true
#@export var prediction = 0.3

@export var next: State

func on_enter() -> void:
	super()
	if not is_instance_valid(state_handler.target):
		state_handler.target = user.ability_relay.find_target()
	if not is_instance_valid(state_handler.target):
		state_handler.change_state(next)
		return
	if recalc_direction:
		#var time_to_hit = user.global_position.distance_to(state_handler.target.global_position) / bullet_speed
		#var predicted_position = state_handler.target.global_position + state_handler.target.velocity * prediction * time_to_hit
		state_handler.data["direction"] = user.global_position.direction_to(state_handler.target.global_position)#user.global_position.direction_to(predicted_position)
	
	var spin_direction = 1 ## beware the evil angles
	if state_handler.target.velocity.length() < 25:
		spin_direction = 0
	else:
		var angle_to_predicted = user.global_position.angle_to_point(state_handler.target.global_position + state_handler.target.velocity)
		var angle_to_target = user.global_position.angle_to_point(state_handler.target.global_position)
		if angle_difference(angle_to_target, angle_to_predicted) < 0:
			spin_direction = -1
	
	var laser_instance = user.ability_relay.make_projectile(laser, 
	user.global_position, 
	{"subscription" = 2},
	state_handler.data["direction"] * bullet_speed)
	laser_instance.get_node("Lifetime").wait_time = bullet_lifetime
	laser_instance.spin = 0.5 * spin_direction
	get_node("/root/Main/Projectiles").add_child(laser_instance)
	#user.ability_relay.attack.emit(direction)
	get_node("/root/Main").play_sound("ShootLight")
	state_handler.target = null
	state_handler.change_state(next)
