extends Projectile

@onready var collision_shape = $CollisionShape2D
@onready var sprite = $Sprite
@onready var lifetime = $Lifetime

@export var quake_scene = preload("res://generic/particles/quake.tscn")

func _physics_process(delta):
	super(delta)
	if lifetime.time_left > 0.2:
		for body in get_overlapping_bodies():
			if body is Entity and body.health > 0:
				lifetime.start(0.2)
				break

func _on_lifetime_timeout() -> void:
	hit_enabled = true
	_physics_process(0)
	get_node("/root/Main").spawn_particles(quake_scene, ability_handler.owner.global_position, scale.x, sprite.modulate)
	var crits = ability_handler.get_crits()
	on_collision(global_position, null, crits)
	kill()
