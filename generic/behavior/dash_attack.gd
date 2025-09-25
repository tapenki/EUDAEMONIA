extends State

@onready var timer = $"Timer"

@export var speed: int

@export var next: State

var stick_normal: Vector2
var stick: bool
var direction: Vector2

func on_enter() -> void:
	super()
	if not is_instance_valid(state_handler.target):
		state_handler.target = user.ability_handler.find_target()
	
	user.velocity = Vector2()
	if is_instance_valid(state_handler.target):
		direction = user.global_position.direction_to(state_handler.target.global_position)
	else:
		direction = Vector2.from_angle(randf()*TAU)
		
	if user.is_on_wall():
		stick_normal = user.get_last_slide_collision().get_normal()
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
			if collision.get_normal() != stick_normal:
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
