class_name Hurtbox extends Area2D

@export var ability_relay: Node2D
@export var hit_sound = "HitLight"

@export var hit_delay: = 0.5

var exclude: Dictionary
@export var hit_enabled = true

func on_collision(_collision_position: Vector2, _body: Node, _crits: int):
	#ability_relay.attack_impact.emit(collision_position, body)
	if hit_sound:
		get_node("/root/Main").play_sound(hit_sound)

func hurt(entity):
	if exclude.has(entity):
		return
	exclude[entity] = hit_delay
	var damage = ability_relay.deal_damage(entity, {"base" : 0, "multiplier" : 1, "direction" : get_knockback_direction(entity)})
	on_collision(entity.global_position, entity, damage["crits"])
	if ability_relay.owner is Entity and is_instance_valid(entity.hurtbox):
		entity.hurtbox.hurt(ability_relay.owner)

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body is Entity and not body.is_ancestor_of(self) and body.alive and hit_enabled:
			hurt(body)
	for body in exclude.keys():
		exclude[body] -= delta * ability_relay.speed_scale
		if exclude[body] <= 0:
			exclude.erase(body)

func get_knockback_direction(target):
	return lerp(ability_relay.owner.velocity, global_position.direction_to(target.global_position), 1/max(ability_relay.owner.velocity.length()*0.01, 1)).normalized()
