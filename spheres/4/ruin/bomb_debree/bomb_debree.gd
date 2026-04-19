extends OrbitingEntity

var explosion_scene = preload("res://generic/projectiles/explosion.tscn")

func _ready() -> void:
	super()
	ability_relay.damage_taken.connect(damage_taken)
	ability_relay.death_effects.connect(death_effects)

func damage_taken(_damage) -> void:
	if not get_node("Lifetime").running and alive:
		get_node("Lifetime").start(4)
		ability_relay.owner.get_node("AnimationPlayer").play("PRIMED")

func death_effects():
	loosen()
	var explosion_instance = ability_relay.make_projectile(explosion_scene, 
	global_position, ## position
	{"subscription" = 2}, ## inheritance
	Vector2()) ## velocity
	explosion_instance.exclude[ability_relay.owner] = INF
	explosion_instance.scale_multiplier = 2
	get_node("/root/Main/Projectiles").add_child(explosion_instance)
	get_node("/root/Main").play_sound("Explosion")

func loosen():
	if not get_node("Lifetime").running:
		if alive:
			ability_relay.owner.get_node("AnimationPlayer").play("PRIMED")
		get_node("Lifetime").start(2)
	elif get_node("Lifetime").time_left > 2:
		get_node("Lifetime").start(2)
	loose = true
	reparent(get_node("/root/Main/Entities"), true)
