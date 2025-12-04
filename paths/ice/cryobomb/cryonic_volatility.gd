extends Ability

var explosion_scene = preload("res://generic/projectiles/explosion.tscn")

var explosion_timer = ScaledTimer.new()

var stored_damage: float

func _ready() -> void:
	explosion_timer.ability_handler = ability_handler
	add_child(explosion_timer)
	explosion_timer.timeout.connect(timeout)
	ability_handler.damage_taken.connect(damage_taken)
	ability_handler.before_self_death.connect(before_self_death)
	ability_handler.death_effects.connect(death_effects)

func damage_taken(_source, damage) -> void:
	stored_damage += damage["final"]

func before_self_death(modifiers) -> void:
	modifiers["soft_prevented"] = true
	if not explosion_timer.running and ability_handler.owner.alive:
		explosion_timer.start(3)
		ability_handler.owner.get_node("AnimationPlayer").play("PRIMED")

func death_effects():
	var explosion_instance = ability_handler.make_projectile(explosion_scene, 
	global_position, ## position
	2, ## inheritance
	Vector2()) ## velocity
	explosion_instance.exclude[ability_handler.owner] = INF
	explosion_instance.ability_handler.inherited_damage["source"] += stored_damage
	explosion_instance.scale_multiplier = 8
	get_node("/root/Main/Projectiles").add_child(explosion_instance)
	get_node("/root/Main").play_sound("Explosion")

func timeout() -> void:
	ability_handler.owner.kill()

func inherit(_handler, _tier):
	return
