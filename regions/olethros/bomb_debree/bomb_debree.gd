extends OrbitingEntity

var explosion_scene = preload("res://generic/projectiles/explosion.tscn")

func _ready() -> void:
	super()
	ability_handler.damage_taken.connect(damage_taken)
	ability_handler.before_self_death.connect(before_self_death)

func damage_taken(_source, _damage) -> void:
	if not get_node("Lifetime").running and alive:
		get_node("Lifetime").start()
		ability_handler.owner.get_node("AnimationPlayer").play("PRIMED")

func before_self_death(modifiers) -> void:
	modifiers["prevented"] = true

func loosen():
	if not get_node("Lifetime").running and alive:
		ability_handler.owner.get_node("AnimationPlayer").play("PRIMED")
	super()

func kill():
	if alive:
		var explosion_instance = ability_handler.make_projectile(explosion_scene, 
		global_position, ## position
		3, ## inheritance
		Vector2()) ## velocity
		explosion_instance.scale_multiplier = 2
		get_node("/root/Main/Projectiles").add_child(explosion_instance)
		get_node("/root/Main").play_sound("Explosion")
	super()
