extends Node2D

var particle_scene = preload("res://generic/particles/heptagram.tscn")
var particle_instances: Array

var entity: Node

func set_spawn(node):
	entity = node
	modulate = node.get_node("Sprite").self_modulate
	for sprite in node.get_sprites():
		var particle_instance = particle_scene.instantiate()
		particle_instance.position = sprite["position"]+sprite["offset"]
		particle_instance.scale *= particle_instance.amount * sqrt(sprite["size"].x * sprite["size"].y) * 0.004
		particle_instances.append(particle_instance)
		add_child(particle_instance)

func _on_spawn_timer_timeout() -> void:
	get_node("/root/Main/Entities").add_child(entity)
	for particles in particle_instances:
		particles.self_death()
	queue_free()

func _physics_process(_delta: float) -> void:
	self_modulate = Color.WHITE * (1 - sin(Time.get_ticks_msec()*0.02) * 0.33)
