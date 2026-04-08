extends OrbitingEntity

var explosion_scene = preload("res://generic/projectiles/explosion.tscn")

func _ready() -> void:
	super()
	ability_relay.before_self_death.connect(before_self_death)
	ability_relay.death_effects.connect(death_effects)

func before_self_death(modifiers) -> void:
	modifiers["soft_prevented"] = true
	if not get_node("Lifetime").running and alive:
		get_node("Lifetime").start()
		ability_relay.owner.get_node("AnimationPlayer").play("PRIMED")

func death_effects():
	var explosion_instance = ability_relay.make_projectile(explosion_scene, 
	global_position, ## position
	{"subscription" = 2}, ## inheritance
	Vector2()) ## velocity
	explosion_instance.exclude[ability_relay.owner] = INF
	explosion_instance.scale_multiplier = 2
	get_node("/root/Main/Projectiles").add_child(explosion_instance)
	get_node("/root/Main").play_sound("Explosion")

func loosen():
	if not get_node("Lifetime").running and alive:
		ability_relay.owner.get_node("AnimationPlayer").play("PRIMED")
	super()
