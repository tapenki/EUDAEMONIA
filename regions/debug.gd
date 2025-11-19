extends Node2D

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_0:
		print("growed")
		scale += Vector2(1, 1)
	if event is InputEventKey and event.pressed and event.keycode == KEY_9:
		print("shrinked")
		scale -= Vector2(1, 1)
