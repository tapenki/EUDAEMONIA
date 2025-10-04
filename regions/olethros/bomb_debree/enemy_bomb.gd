extends Node2D

@export var ability_handler: Node

@export var explosion_scale = 1.0
@export var explosion_delay = 1.0

var explosion_scene = preload("res://generic/projectiles/explosion.tscn")

var explosion_timer = ScaledTimer.new()

func _ready() -> void:
	explosion_timer.ability_handler = ability_handler
	add_child(explosion_timer)
	explosion_timer.timeout.connect(timeout)
	ability_handler.damage_taken.connect(damage_taken)
	ability_handler.before_self_death.connect(before_self_death)
	ability_handler.self_death.connect(self_death)

func timeout() -> void:
	ability_handler.owner.kill()

func damage_taken(_source, _damage) -> void:
	if not explosion_timer.running and ability_handler.owner.alive:
		explosion_timer.start(explosion_delay)
		ability_handler.owner.get_node("AnimationPlayer").play("PRIMED")

func before_self_death(modifiers) -> void:
	modifiers["prevented"] = true

func self_death() -> void:
	var explosion_instance = ability_handler.make_projectile(explosion_scene, 
	global_position, ## position
	3, ## inheritance
	Vector2()) ## velocity
	explosion_instance.scale_multiplier = explosion_scale
	get_node("/root/Main/Projectiles").add_child(explosion_instance)
	get_node("/root/Main").play_sound("Explosion")
