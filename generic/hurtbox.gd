class_name Hurtbox extends Area2D

@export var ability_handler: Node2D
@export var hit_sound: String

@export var damage_modifiers = {"source" : 0.0, "multiplier" : 1.0}
@export var hit_delay: = 0.5

var exclude: Dictionary
@export var hit_enabled = true

func on_collision(collision_position: Vector2, body: Node):
	ability_handler.attack_impact.emit(collision_position, body)
	if hit_sound:
		get_node("/root/Main").play_sound(hit_sound)

func on_hit(body, hit_damage):
	ability_handler.damage_dealt.emit(body, hit_damage)
	on_collision(body.global_position, body)

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body is Entity and not body.is_ancestor_of(self) and not exclude.has(body) and body.alive and hit_enabled:
			exclude[body] = hit_delay
			var damage = ability_handler.get_damage_dealt(body, damage_modifiers)
			on_hit(body, damage)
			body.take_damage(ability_handler.owner, damage)
	for body in exclude:
		exclude[body] -= delta * ability_handler.speed_scale
		if exclude[body] <= 0:
			exclude.erase(body)
