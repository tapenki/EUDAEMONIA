class_name Hurtbox extends Area2D

@export var ability_handler: Node2D
@export var hit_sound = "HitLight"

@export var hit_delay: = 0.5

var exclude: Dictionary
@export var hit_enabled = true

func on_collision(_collision_position: Vector2, _body: Node, _crits: int):
	#ability_handler.attack_impact.emit(collision_position, body)
	if hit_sound:
		get_node("/root/Main").play_sound(hit_sound)

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body is Entity and not body.is_ancestor_of(self) and not exclude.has(body) and body.alive and hit_enabled:
			exclude[body] = hit_delay
			var damage = ability_handler.deal_damage(body)
			on_collision(body.global_position, body, damage["crits"])
	for body in exclude.keys():
		exclude[body] -= delta * ability_handler.speed_scale
		if exclude[body] <= 0:
			exclude.erase(body)
