extends State

@export var reticle: PackedScene
@export var bullet_lifetime: float
@export var bullet_count: int = 8
@export var area: int = 150
@export var next: State

func on_enter() -> void:
	super()
	if not is_instance_valid(state_handler.target):
		state_handler.target = user.ability_handler.find_target()
	
	if is_instance_valid(state_handler.target):
		for i in bullet_count:
			var ray_query = PhysicsRayQueryParameters2D.new()
			ray_query.from = state_handler.target.global_position
			ray_query.to = state_handler.target.global_position + state_handler.target.velocity * bullet_lifetime * 0.9 + Vector2.from_angle(TAU / bullet_count * i) * area
			ray_query.collision_mask = 128
			var raycast_result = get_node("/root/Main").physics_space.intersect_ray(ray_query)
			var reticle_instance = user.ability_handler.make_projectile(reticle, 
			raycast_result.get("position", ray_query.to), 
			2)
			reticle_instance.get_node("Lifetime").wait_time = bullet_lifetime
			get_node("/root/Main/Projectiles").add_child(reticle_instance)
			#user.ability_handler.attack.emit(direction)
			get_node("/root/Main").play_sound("ShootLight")
	state_handler.target = null
	state_handler.change_state(next)
