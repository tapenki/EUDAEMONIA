class_name Laser extends Node2D

@export var ability_relay: Node2D

@export var hit_delay: = 0.5
@export var hit_enabled = true
@export var hit_walls = true

var velocity: Vector2
@export var max_length = 1000
var length = 0.0
var spin = 0.0
@export var laser_offset = 25
#@export var max_length = 1000
@export_category("Tags")
@export var group: int

var alive = true

@onready var sprite = get_node("Sprite")

var exclude: Dictionary

var sound_timer = 0.0

func _ready() -> void:
	rotation = velocity.angle()
	var attack_scale = adjust_scale()
	sprite.position.x = laser_offset / attack_scale

func _physics_process(delta):
	tick_exclusion(delta)
	var attack_scale = adjust_scale()
	velocity = velocity.rotated(spin * delta * ability_relay.speed_scale)
	length = min(max_length, length + velocity.length() * delta * ability_relay.speed_scale)
	rotation = velocity.angle()
	var wall_intersections = wall_collision()
	sprite.position.x = laser_offset / attack_scale
	if wall_intersections:
		sprite.size.x = position.distance_to(wall_intersections.position) / attack_scale - sprite.position.x
		entity_collision(wall_intersections.position, sprite.size.y * attack_scale * 0.5)
	else:
		sprite.size.x = length / attack_scale - sprite.position.x
		entity_collision(global_position + velocity.normalized() * length, sprite.size.y * attack_scale * 0.5)
	#sound_effects(delta)

func tick_exclusion(delta):
	for body in exclude.keys():
		exclude[body] -= delta * ability_relay.speed_scale
		if exclude[body] <= 0:
			exclude.erase(body)

func wall_collision():
	if hit_walls:
		var wall_intersections
		var ray_query = PhysicsRayQueryParameters2D.create(global_position, global_position + velocity.normalized() * length)
		ray_query.collision_mask = 128
		wall_intersections = get_node("/root/Main").physics_space.intersect_ray(ray_query)
		return wall_intersections
		#if shape_intersections:
			#if hit_particle_preset != "":
				#get_node("/root/Main/ParticleHandler").quick_particles(hit_particle_preset, 
				#hit_particle_texture,
				#tip_position,
				#hit_particle_scale * scale.x,
				#hit_particle_count,
				#get_node("Sprite").self_modulate)
			#if hit_sound:
				#get_node("/root/Main").play_sound(hit_sound)
			#kill()

func entity_collision(endpoint, width = 8):
	var shape_intersections
	var perpendicular = velocity.normalized().rotated(PI/2)
	var cloud = PackedVector2Array([
		global_position + perpendicular * width,
		global_position - perpendicular * width,
		endpoint + perpendicular * width,
		endpoint - perpendicular * width
	])
	var shape_query = PhysicsShapeQueryParameters2D.new()
	shape_query.shape = ConvexPolygonShape2D.new()
	shape_query.shape.set_point_cloud(cloud)
	shape_query.collision_mask = ability_relay.enemies_mask()
	shape_intersections = get_node("/root/Main").physics_space.intersect_shape(shape_query, 1)
	for entity in shape_intersections:
		if entity["collider"] is Entity and not entity["collider"].is_ancestor_of(self) and not exclude.has(entity["collider"]) and entity["collider"].alive and hit_enabled:
			exclude[entity["collider"]] = hit_delay
			ability_relay.deal_damage(entity["collider"])

func adjust_scale():
	var attack_scale = ability_relay.get_attack_scale()
	scale = Vector2(attack_scale, attack_scale)
	return attack_scale

func sound_effects(delta):
	sound_timer += delta * ability_relay.speed_scale
	if sound_timer > 0.25:
		sound_timer = 0
		get_node("/root/Main").play_sound("Error")

#func get_knockback_direction(target):
#	return lerp(velocity, global_position.direction_to(target.global_position), 1/max(velocity.length()*0.01, 1)).normalized()

func _on_lifetime_timeout() -> void:
	kill()

func kill():
	if alive:
		alive = false
		queue_free()
		hit_enabled = false
		ability_relay.death_effects.emit()
		ability_relay.self_death.emit()
		ability_relay.freed.emit()

func get_sprites():
	var attack_scale = ability_relay.get_attack_scale()
	return [{"node" : sprite, "size" : sprite.size * attack_scale, "position" : global_position, "offset" : Vector2()}]

func apply_palette(team, denominator):
	var colored_sprite = get_node("Sprite")
	var team_color = Config.get_team_color(team, denominator)
	colored_sprite.self_modulate = team_color
	for spritechild in colored_sprite.get_children():
		if spritechild is CanvasItem:
			spritechild.modulate = team_color
