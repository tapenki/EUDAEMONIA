extends State

@onready var timer = $"Timer"

@export var speed: int
@export var back_off_distance: int
@export var close_in_distance: int

@export var next: State

var direction: Vector2

func _physics_process(_delta):
	var final_speed = user.ability_handler.get_move_speed(speed) * user.ability_handler.speed_scale
	if user.is_on_wall():
		direction = direction.bounce(user.get_last_slide_collision().get_normal())
	user.velocity = lerp(user.velocity, direction * final_speed, 0.5)

func on_enter() -> void:
	super()
	state_handler.target = user.ability_handler.find_target()
	if is_instance_valid(state_handler.target):
		var distance = user.global_position.distance_to(state_handler.target.global_position)
		if distance < back_off_distance:
			direction = user.global_position.direction_to(state_handler.target.global_position) * -1
		elif distance > close_in_distance:
			direction = user.global_position.direction_to(state_handler.target.global_position)
		else:
			direction = Vector2.from_angle(randf()*TAU)
	else:
		direction = Vector2.from_angle(randf()*TAU)
	timer.start()
	user.animation_player.play("WALK")

func _on_timer_timeout() -> void:
	state_handler.change_state(next)
