class_name SliderSetting extends Label

@export var section : String
@export var key : String
@export var min_value = 0.0
@export var max_value = 1.0

@onready var slider = $"HSlider"
@onready var value_label = $"Value"

func _ready() -> void:
	slider.min_value = min_value
	slider.max_value = max_value
	
	var value = Config.config.get_value(section, key)
	slider.value = value
	
	value_label.text = "[%s]%%" % roundi(value * 100)

func value_changed(value):
	value_label.text = "[%s]%%" % roundi(value * 100)

func drag_ended(_changed: bool) -> void:
	Config.config.set_value(section, key, slider.value)
	Config.config.save("user://config.ini")
	Config.value_changed.emit(section, key)
	get_node("/root/Main").play_sound("Click")
