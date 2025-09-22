class_name Projectile extends Hurtbox

@export var hit_particles: PackedScene

@export var hit_walls = false
@export var hits_left = 1
var velocity: Vector2

@export var group: int

func _ready() -> void:
	adjust_scale()

func on_collision(collision_position: Vector2, body: Node):
	if hit_particles:
		get_node("/root/Main").spawn_particles(hit_particles, global_position, scale.x, get_node("Sprite").modulate)
	super(collision_position, body)

func kill():
	queue_free()
	hit_enabled = false
	ability_handler.self_death.emit()

func _physics_process(delta):
	adjust_scale()
	translate(velocity * delta * ability_handler.speed_scale)
	super(delta)
	if hit_walls:
		for body in get_overlapping_bodies():
			if body is TileMapLayer:
				on_collision(global_position, body)
				kill()

func on_hit(body, hit_damage):
	super(body, hit_damage)
	hits_left -= 1
	if hits_left == 0:
		kill()

func _on_lifetime_timeout() -> void:
	on_collision(global_position, null)
	kill()

func adjust_scale():
	var attack_scale = ability_handler.get_attack_scale()
	scale = Vector2(attack_scale, attack_scale)
