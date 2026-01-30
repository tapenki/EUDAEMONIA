extends Control

@export var rotation_speed = 1.0

func _process(delta: float) -> void:
	rotation += delta * rotation_speed
