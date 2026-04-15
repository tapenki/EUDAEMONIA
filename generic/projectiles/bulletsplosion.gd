extends Node2D

@export var ability_relay: Node

var bullet = preload("res://generic/projectiles/bullet.tscn")

func _ready() -> void:
	ability_relay.death_effects.connect(death_effects)

func death_effects() -> void:
	var bullet_count = 3
	var direction = ability_relay.owner.velocity.normalized() * -1
	var stepsize = deg_to_rad(120) / (bullet_count - 1)
	var halfspan = deg_to_rad(120) * 0.5
	for i in bullet_count:
		var bullet_instance = ability_relay.make_projectile(bullet, 
		global_position + direction * 25, 
		{"subscription" = 2},
		direction.rotated(halfspan - (stepsize * i)) * 300)
		get_node("/root/Main/Projectiles").add_child(bullet_instance)
