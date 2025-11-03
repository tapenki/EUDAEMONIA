extends Node2D

@export var ability_handler: Node

var bullet = preload("res://generic/projectiles/bullet.tscn")
var splosion = preload("res://generic/projectiles/explosion.tscn")

func _ready() -> void:
	ability_handler.death_effects.connect(death_effects)

func death_effects() -> void:
	var splosion_instance = ability_handler.make_projectile(splosion, 
	global_position, 
	3)
	get_node("/root/Main/Projectiles").add_child(splosion_instance)
	var bullet_count = 3
	var direction = ability_handler.owner.velocity.normalized() * -1
	var stepsize = deg_to_rad(120) / (bullet_count - 1)
	var halfspan = deg_to_rad(120) * 0.5
	for i in bullet_count:
		var bullet_instance = ability_handler.make_projectile(bullet, 
		global_position + direction * 25, 
		3,
		direction.rotated(halfspan - (stepsize * i)) * 450)
		get_node("/root/Main/Projectiles").add_child(bullet_instance)
