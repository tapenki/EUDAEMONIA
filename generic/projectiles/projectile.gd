class_name Projectile extends Area2D

@export var ability_handler: Node2D
@export var hit_sound = "HitLight"
@export var hit_particles: String = "Impact"
@export var crit_particles: String = "Zap"

@export var hit_delay: = 0.5
@export var hit_enabled = true

@export var hit_walls = false
@export var hits_left = 1
var velocity: Vector2

@export var group: int

var alive = true

var exclude: Dictionary

func _ready() -> void:
	adjust_scale()

func _physics_process(delta):
	entity_collision()
	tick_exclusion(delta)
	wall_collision()
	
	adjust_scale()
	movement(delta)

func entity_collision():
	for body in get_overlapping_bodies():
		if body is Entity and not body.is_ancestor_of(self) and not exclude.has(body) and body.alive and hit_enabled:
			exclude[body] = hit_delay
			var damage = ability_handler.deal_damage(body)
			on_hit(damage["crits"])

func tick_exclusion(delta):
	for body in exclude.keys():
		exclude[body] -= delta * ability_handler.speed_scale
		if exclude[body] <= 0:
			exclude.erase(body)

func wall_collision():
	if hit_walls:
		for body in get_overlapping_bodies():
			if body is TileMapLayer:
				var crits = 0#ability_handler.get_crits()
				on_collision(crits)
				kill()

func movement(delta):
	var old_position = global_position
	translate(velocity * delta * ability_handler.speed_scale)
	ability_handler.movement.emit(old_position.distance_to(global_position))

func on_collision(crits: int):
	if hit_particles:
		get_node("/root/Main").spawn_particles(get_node("/root/Main/Particles/" + hit_particles), 4, global_position, scale.x, get_node("Sprite").modulate)
	if crits > 0 and crit_particles:
		get_node("/root/Main").spawn_particles(get_node("/root/Main/Particles/" + crit_particles), 4, global_position, scale.x, get_node("Sprite").modulate)
	if hit_sound:
		get_node("/root/Main").play_sound(hit_sound)

func on_hit(crits):
	on_collision(crits)
	hits_left -= 1
	if hits_left == 0:
		kill()

func _on_lifetime_timeout() -> void:
	var crits = 0#ability_handler.get_crits()
	on_collision(crits)
	kill()

func adjust_scale():
	var attack_scale = ability_handler.get_attack_scale()
	scale = Vector2(attack_scale, attack_scale)

func kill():
	if alive:
		alive = false
		queue_free()
		hit_enabled = false
		ability_handler.self_death.emit()
