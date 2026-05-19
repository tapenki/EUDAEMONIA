extends State

@export var scale = 1.0
@export var distance = 30.0

@export var next: State

var projectile_scene = preload("res://generic/projectiles/explosion.tscn")

func on_enter() -> void:
	var attack_position = user.global_position
	if state_handler.data.has("direction"):
		attack_position += state_handler.data["direction"] * distance * scale
	var projectile_instance = user.ability_relay.make_projectile(projectile_scene, 
	attack_position, 
	{"subscription" = 2})
	projectile_instance.scale_multiplier = scale
	get_node("/root/Main/Projectiles").add_child(projectile_instance)
	get_node("/root/Main").play_sound("HurtLight")
	change_state(next)
