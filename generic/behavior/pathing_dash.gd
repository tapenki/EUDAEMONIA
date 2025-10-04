extends State

@onready var timer = $"Timer"

@export var speed: int
@export var sound = "Leap"

@export var next: State

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
	timer.start()
	
	state_handler.target = null

func _physics_process(_delta):
	var final_speed = user.ability_handler.get_move_speed(speed) * user.ability_handler.speed_scale
	if user.is_on_wall():
		user.velocity = Vector2()
		direction = direction.bounce(user.get_last_slide_collision().get_normal())
	user.velocity = lerp(user.velocity, direction * final_speed, 0.25)

func _on_timer_timeout() -> void:
	#user.ability_handler.attack.emit(direction)
	state_handler.change_state(next)

func on_exit() -> void:
	user.velocity = Vector2()
	user.wall_min_slide_angle = 0
	super()
