extends State

@export var speed: int
@export var distance_margin: int

@export var next: State

func avoidance():
	var reach = 3000
	var found
	for entity in get_node("/root/Main/Entities").get_children():
		if entity != user and not user.ability_handler.can_hit(entity):
			var distance = user.global_position.distance_to(entity.global_position)
			if distance < reach:
				reach = distance
				found = entity
	return found

func _physics_process(_delta):
	var direction: Vector2
	if not is_instance_valid(state_handler.target):
		state_handler.target = user.ability_handler.find_target()
	if is_instance_valid(state_handler.target):
		var distance = user.global_position.distance_to(state_handler.target.global_position)
		direction = user.global_position.direction_to(state_handler.target.global_position)
		if distance < distance_margin:
			state_handler.data["direction"] = direction
			state_handler.change_state(next)
		else:
			user.animation_player.play("WALK")
	else:
		user.animation_player.play("RESET")
	var final_speed = user.ability_handler.get_move_speed(speed) * user.ability_handler.speed_scale
	user.velocity = lerp(user.velocity, direction * final_speed, 0.5)
	if direction != Vector2():
		var avoid = avoidance()
		if avoid:
			var avoid_direction = avoid.global_position.direction_to(user.global_position)
			user.velocity = lerp(user.velocity, avoid_direction * final_speed, 0.075)
