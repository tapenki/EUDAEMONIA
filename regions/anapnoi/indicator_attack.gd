extends State

@export var reticle: PackedScene
@export var bullet_lifetime: float
@export var next: State

func on_enter() -> void:
	super()
	if not is_instance_valid(state_handler.target):
		state_handler.target = user.ability_handler.find_target()
	
	if is_instance_valid(state_handler.target):
		var reticle_instance = user.ability_handler.make_projectile(reticle, 
		state_handler.target.global_position + state_handler.target.velocity * bullet_lifetime, 
		2)
		reticle_instance.get_node("Lifetime").wait_time = bullet_lifetime
		get_node("/root/Main/Projectiles").add_child(reticle_instance)
		#user.ability_handler.attack.emit(direction)
		get_node("/root/Main").play_sound("ShootLight")
	state_handler.target = null
	state_handler.change_state(next)
