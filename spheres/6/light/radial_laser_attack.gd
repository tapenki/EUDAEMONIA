extends State

@export var laser: PackedScene
@export var laser_lifetime: float
@export var laser_count: int
@export var angle: float
@export var laser_speed = 600
@export var laser_length = 600
@export var spin = 1.0

@export var next: State

func on_enter() -> void:
	super()
	for i in laser_count:
		var laser_instance = user.ability_relay.make_projectile(laser, 
		user.global_position, 
		{"subscription" = 2},
		Vector2.from_angle(deg_to_rad(angle) + (TAU / laser_count * i)) * laser_speed)
		laser_instance.get_node("Lifetime").wait_time = laser_lifetime
		get_node("/root/Main/Projectiles").add_child(laser_instance)
		laser_instance.spin = spin
		laser_instance.max_length = laser_length
	get_node("/root/Main").play_sound("Explosion")
	change_state(next)
