class_name Projectile extends Hurtbox

@export var hit_particles: PackedScene
@export var crit_particles: PackedScene = preload("res://paths/white_magic/zap.tscn")

@export var hit_walls = false
@export var hits_left = 1
var velocity: Vector2

@export var group: int

func _ready() -> void:
	adjust_scale()

func on_collision(collision_position: Vector2, body: Node, crits: int):
	if hit_particles:
		get_node("/root/Main").spawn_particles(hit_particles, global_position, scale.x, get_node("Sprite").modulate)
	if crits > 0 and crit_particles:
		get_node("/root/Main").spawn_particles(crit_particles, global_position, scale.x, get_node("Sprite").modulate)
	super(collision_position, body, crits)

func kill():
	queue_free()
	hit_enabled = false
	ability_handler.self_death.emit()

func _physics_process(delta):
	adjust_scale()
	movement(delta)
	super(delta)
	if hit_walls:
		for body in get_overlapping_bodies():
			if body is TileMapLayer:
				var crits = ability_handler.get_crits()
				on_collision(global_position, body, crits)
				kill()

func movement(delta):
	var old_position = global_position
	translate(velocity * delta * ability_handler.speed_scale)
	ability_handler.movement.emit(old_position.distance_to(global_position))

func on_hit(body, hit_damage, crits):
	super(body, hit_damage, crits)
	hits_left -= 1
	if hits_left == 0:
		kill()

func _on_lifetime_timeout() -> void:
	var crits = ability_handler.get_crits()
	on_collision(global_position, null, crits)
	kill()

func adjust_scale():
	var attack_scale = ability_handler.get_attack_scale()
	scale = Vector2(attack_scale, attack_scale)
