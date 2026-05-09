class_name UIScaler extends Control

func _ready() -> void:
	get_viewport().size_changed.connect(update_ui_scale)
	Config.value_changed.connect(
		func(section, key):
			if section == "display" and (key == "ui_scale_windowed" or key == "ui_scale_maximized"):
				update_ui_scale()
	)
	update_ui_scale()

func update_ui_scale():
	var updated_scale
	var window = get_window()
	if window.mode == window.MODE_MAXIMIZED or window.mode == window.MODE_FULLSCREEN:
		updated_scale = Config.config.get_value("display", "ui_scale_maximized")
	else:
		updated_scale = Config.config.get_value("display", "ui_scale_windowed")
	scale = Vector2(updated_scale, updated_scale)
