extends State

@onready var timer = $"Timer"

@export var speed: int
@export var sound = "Leap"

@export var bullet: PackedScene

@export var next: State

var bullet_counter: float

var stick_normal: Vector2
var stick: bool

func on_enter() -> void:
	super()
	user.velocity = Vector2()
	if not is_instance_valid(state_handler.target):
		state_handler.target = user.ability_relay.find_target()
	if is_instance_valid(state_handler.target):
		#var time_to_hit = user.global_position.distance_to(state_handler.target.global_position) / speed
		#var predicted_position = state_handler.target.global_position + state_handler.target.velocity * 0.3 * time_to_hit
		state_handler.data["direction"] = user.global_position.direction_to(state_handler.target.global_position)#user.global_position.direction_to(predicted_position)
	else:
		state_handler.data["direction"] = Vector2.from_angle(randf()*TAU)
	
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

func _physics_process(delta):
	var final_speed = user.ability_relay.get_move_speed(speed)
	user.velocity = lerp(user.velocity, state_handler.data["direction"] * final_speed, 0.2)
	user.still = false
	if user.is_on_wall():
		for i in user.get_slide_collision_count():
			var collision = user.get_slide_collision(i)
			if round(collision.get_normal().x) != stick_normal.x or round(collision.get_normal().y) != stick_normal.y:
				stick = false
		if not stick:
			_on_timer_timeout()
	elif stick:
		user.wall_min_slide_angle = 180
		stick = false
	bullet_counter += delta * user.ability_relay.speed_scale
	if bullet_counter >= 0.1:
		bullet_counter -= 0.1
		for i in 2:
			var bullet_instance = user.ability_relay.make_projectile(bullet, 
			user.global_position, 
			{"subscription" = 2},
			state_handler.data["direction"].rotated(randf_range(-1, 1)) * -250 * randf_range(1, 2))
			get_node("/root/Main/Projectiles").add_child(bullet_instance)
		get_node("/root/Main").play_sound("ShootLight")

func _on_timer_timeout() -> void:
	#user.ability_relay.attack.emit(direction)
	state_handler.change_state(next)

func on_exit() -> void:
	user.velocity = Vector2()
	user.wall_min_slide_angle = 0
	bullet_counter = 0
	super()
