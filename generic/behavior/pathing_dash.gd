extends State

@onready var timer = $"Timer"

@export var speed: int
@export var sound = "Leap"

@export var next: State

var stick_normal: Vector2
var stick: bool
var direction: Vector2

var nav_parameters = NavigationPathQueryParameters2D.new()
var nav_result = NavigationPathQueryResult2D.new()

func on_enter() -> void:
	super()
	if not is_instance_valid(state_handler.target):
		state_handler.target = user.ability_handler.find_target()
	
	user.velocity = Vector2()
	if is_instance_valid(state_handler.target):
		nav_parameters.map = get_viewport().world_2d.navigation_map
		nav_parameters.start_position = user.global_position
		nav_parameters.target_position = state_handler.target.global_position
		NavigationServer2D.query_path(nav_parameters, nav_result)
		direction = user.global_position.direction_to(nav_result.path[1])
	else:
		direction = Vector2.from_angle(randf()*TAU)
	
	if sound != "":
		get_node("/root/Main").play_sound(sound)
	if user.is_on_wall():
		stick_normal = user.get_last_slide_collision().get_normal()
		stick_normal.x = round(stick_normal.x)
		stick_normal.y = round(stick_normal.y)
		user.wall_min_slide_angle = 0
		stick = true
	else:
		user.wall_min_slide_angle = 180
		stick = false
	timer.start()
	
	state_handler.target = null

func _physics_process(_delta):
	var final_speed = user.ability_handler.get_move_speed(speed) * user.ability_handler.speed_scale
	user.velocity = lerp(user.velocity, direction * final_speed, 0.5)
	if user.is_on_wall():
		for i in user.get_slide_collision_count():
			var collision = user.get_slide_collision(i)
			if round(collision.get_normal().x) != stick_normal.x or round(collision.get_normal().y) != stick_normal.y:
				stick = false
		if not stick:
			#get_node("/root/Main").spawn_particles("Impact", user.global_position, user.scale.x * 1.5, user.get_node("Sprite").modulate)
			_on_timer_timeout()
	elif stick:
		user.wall_min_slide_angle = 180
		stick = false

func _on_timer_timeout() -> void:
	#user.ability_handler.attack.emit(direction)
	state_handler.change_state(next)

func on_exit() -> void:
	user.velocity = Vector2()
	user.wall_min_slide_angle = 0
	super()
