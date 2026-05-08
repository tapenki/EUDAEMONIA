class_name UIScaler extends Control

func _ready() -> void:
	Config.value_changed.connect(
		func(section, key):
			if section == "display" and key == "ui_scale":
				update(Config.config.get_value("display", "ui_scale"))
	)
	update(Config.config.get_value("display", "ui_scale"))

func update(updated_scale):
	scale = Vector2(updated_scale, updated_scale)
