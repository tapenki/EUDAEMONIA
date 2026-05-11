extends State

@export var speed = 300

@export var next: State

var walk_target: Vector2

func on_enter() -> void:
	super()
	walk_target = user.random_valid_position(get_node("/root"))

func _physics_process(delta):
	if user.global_position.distance_to(walk_target) < speed * delta * user.ability_relay.speed_scale:
		user.velocity *= 0
		user.global_position = walk_target
		change_state(next)
	var to_target = user.global_position.direction_to(walk_target) * speed
	user.velocity = to_target
