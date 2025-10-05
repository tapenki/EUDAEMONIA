extends State

@export var scale = 1.0

@export var next: State

var projectile_scene = preload("res://generic/projectiles/explosion.tscn")

func on_enter() -> void:
	var projectile_instance = user.ability_handler.make_projectile(projectile_scene, 
	user.global_position, 
	3)
	projectile_instance.scale_multiplier = scale
	get_node("/root/Main/Projectiles").add_child(projectile_instance)
	get_node("/root/Main").play_sound("HurtLight")
	state_handler.change_state(next)
