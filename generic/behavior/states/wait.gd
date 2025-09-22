class_name WaitState extends State

@onready var timer = $"Timer"

@export var anim: String

@export var backoff_speed: int
@export var backoff_distance: int

@export var next: State

func _physics_process(_delta):
	var velocity: Vector2
	if backoff_speed > 0 and is_instance_valid(user.target) and user.global_position.distance_to(user.target.global_position) < backoff_distance:
		var direction = user.global_position.direction_to(user.target.global_position)
		velocity = direction * backoff_speed * -1
	
	user.velocity = lerp(user.velocity, velocity, 0.5)

func on_enter() -> void:
	super()
	if anim != "":
		user.animation_player.play(anim)
	timer.start()

#func on_exit() -> void:
	#user.animation_player.play("RESET")
	#super()

func _on_timer_timeout() -> void:
	state_handler.change_state(next)
