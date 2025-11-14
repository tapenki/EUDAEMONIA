extends State

@onready var timer = $"Timer"

@export var speed: int
@export var sound = "Leap"

@export var next: State

var direction: Vector2

func on_enter() -> void:
	super()
	if not is_instance_valid(state_handler.target):
		state_handler.target = user.ability_handler.find_target()
	
	user.velocity = Vector2()
	if is_instance_valid(state_handler.target):
		var tilemap = get_node("/root/Main").room_node.get_node("TileMap")
		var start = tilemap.local_to_map(state_handler.target.global_position)
		var end = tilemap.local_to_map(user.global_position)
		var path: PackedVector2Array
		if get_node("/root/Main").astar.is_in_boundsv(start) and get_node("/root/Main").astar.is_in_boundsv(end):
			path = get_node("/root/Main").astar.get_point_path(start, end, true)
		if path.size() > 1:
			var next_position
			for i in path:
				var ray_query = PhysicsRayQueryParameters2D.create(user.global_position, i)
				ray_query.collision_mask = 128
				var intersection = get_node("/root/Main").physics_space.intersect_ray(ray_query)
				if not intersection:
					next_position = i
					break
			if next_position:
				direction = user.global_position.direction_to(next_position)
			else: ## check out my epical staircase
				direction = Vector2.from_angle(randf()*TAU)
		else:
			direction = Vector2.from_angle(randf()*TAU)
	else:
		direction = Vector2.from_angle(randf()*TAU)
	
	if sound != "":
		get_node("/root/Main").play_sound(sound)
	timer.start()
	
	state_handler.target = null

func _physics_process(_delta):
	var final_speed = user.ability_handler.get_move_speed(speed)
	if user.is_on_wall():
		user.velocity = Vector2()
		direction = direction.bounce(user.get_last_slide_collision().get_normal())
	user.velocity = lerp(user.velocity, direction * final_speed, 0.25)
	user.still = false

func _on_timer_timeout() -> void:
	#user.ability_handler.attack.emit(direction)
	state_handler.change_state(next)

func on_exit() -> void:
	user.velocity *= 0.25
	user.wall_min_slide_angle = 0
	super()
