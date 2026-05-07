class_name UIScaler extends Control

func _ready() -> void:
	Config.rescale_ui.connect(update)

func update(updated_scale):
	scale = Vector2(updated_scale, updated_scale)
