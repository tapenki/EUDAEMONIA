extends State

@export var anim: String

var walk_target: Vector2
var wobble = 0

@export var next: State

func on_enter() -> void:
	super()
	walk_target = user.random_valid_position(get_node("/root/Main").room_node.get_node("TileMap"))

func _physics_process(delta):
	if user.global_position.distance_to(walk_target) < 300 * delta * user.ability_relay.speed_scale:
		user.velocity *= 0
		user.global_position = walk_target
		state_handler.change_state(next)
	wobble += delta * user.ability_relay.speed_scale * 12
	var to_target = user.global_position.direction_to(walk_target).rotated(sin(wobble)*0.25) * 300
	user.velocity = to_target
