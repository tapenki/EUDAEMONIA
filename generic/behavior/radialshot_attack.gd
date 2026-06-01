extends State

@export var bullet: PackedScene
@export var bullet_lifetime: float
@export var bullet_count: int
@export var angle: float
@export var bullet_speed = 600

@export var next: State

func on_enter() -> void:
	super()
	for i in bullet_count:
		var bullet_instance = user.ability_relay.make_projectile(bullet, 
		user.global_position, 
		{"subscription" = 2},
		Vector2.from_angle(deg_to_rad(angle) + (TAU / bullet_count * i)) * bullet_speed)
		bullet_instance.get_node("Lifetime").wait_time = bullet_lifetime * bullet_instance.ability_relay.get_effect_duration()
		get_node("/root/Main/Projectiles").add_child(bullet_instance)
	get_node("/root/Main").play_sound("ShootLight")
	change_state(next)
