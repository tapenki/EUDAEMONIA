extends State

@export var bullet: PackedScene
@export var bullet_lifetime: float
@export var bullet_speed = 600

@export var recalc_direction = true

@export var next: State

func on_enter() -> void:
	super()
	if recalc_direction:
		if not is_instance_valid(state_handler.target):
			state_handler.target = user.ability_relay.find_target()
		if not is_instance_valid(state_handler.target):
			state_handler.change_state(next)
			return
		state_handler.data["direction"] = user.global_position.direction_to(state_handler.target.global_position)
	
	var bullet_instance = user.ability_relay.make_projectile(bullet, 
	user.global_position + state_handler.data["direction"] * 25, 
	{"subscription" = 2},
	state_handler.data["direction"] * bullet_speed)
	bullet_instance.get_node("Lifetime").wait_time = bullet_lifetime
	get_node("/root/Main/Projectiles").add_child(bullet_instance)
	#user.ability_relay.attack.emit(direction)
	get_node("/root/Main").play_sound("ShootLight")
	state_handler.target = null
	state_handler.change_state(next)
