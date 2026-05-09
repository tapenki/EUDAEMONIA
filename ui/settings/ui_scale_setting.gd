extends SliderSetting

@export var windowed_key: String
@export var maximized_key: String

func _ready() -> void:
	slider.min_value = min_value
	slider.max_value = max_value
	get_viewport().size_changed.connect(viewport_size_changed)
	viewport_size_changed()

func viewport_size_changed():
	var window = get_window()
	if window.mode == window.MODE_MAXIMIZED or window.mode == window.MODE_FULLSCREEN:
		key = maximized_key
	else:
		key = windowed_key
	var value = Config.config.get_value(section, key)
	slider.value = value
	value_label.text = "[%s]%%" % roundi(value * 100)
