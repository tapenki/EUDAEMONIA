extends Node

var presets = {
	"impact" = preload("res://generic/particles/impact.tscn"),
	"burst" = preload("res://generic/particles/burst.tscn")
}

var beam_presets = {
	"common" = preload("res://generic/particles/particle_beam.tscn")
}

func quick_particles(preset: String, texture: Texture, position: Vector2, scale: float = 1, count: int = -1, color: Color = Color.WHITE):
	var particle_instance = presets[preset].instantiate()
	particle_instance.texture = texture
	particle_instance.position = position
	particle_instance.scale *= scale
	if count > 0:
		particle_instance.amount = count
	particle_instance.modulate = color
	get_node("/root/Main/Effects").add_child(particle_instance)
	particle_instance.emitting = true
	particle_instance.finished.connect(particle_instance.queue_free)

func particle_beam(preset: String, texture: Texture, position0: Vector2, position1: Vector2, scale: float = 1, distance_per_count: int = 32, color: Color = Color.WHITE):
	var particle_instance = beam_presets[preset].instantiate()
	particle_instance.texture = texture
	particle_instance.position = lerp(position0, position1, 0.5)
	particle_instance.scale *= scale
	particle_instance.emission_rect_extents.x = position0.distance_to(position1) / scale / 2
	particle_instance.rotation = position0.angle_to_point(position1)
	particle_instance.amount = max(1, position0.distance_to(position1) / distance_per_count)
	particle_instance.modulate = color
	get_node("/root/Main/Effects").add_child(particle_instance)
	particle_instance.emitting = true
	particle_instance.finished.connect(particle_instance.queue_free)
