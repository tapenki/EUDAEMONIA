extends ParticleSpriteProjectile

var projectile_scene = preload("res://generic/projectiles/explosion.tscn")

func _ready() -> void:
	ability_relay.death_effects.connect(death_effects)
	super()

func death_effects() -> void:
	var projectile_instance = ability_relay.make_projectile(projectile_scene, 
	global_position,
	{"subscription" = 2},
	Vector2())
	projectile_instance.scale_multiplier = 3
	get_node("/root/Main/Projectiles").add_child(projectile_instance)
	get_node("/root/Main").play_sound("Explosion")
