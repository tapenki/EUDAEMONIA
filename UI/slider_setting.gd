extends Label

@export var section : String
@export var key : String

@onready var slider = $"HSlider"
@onready var value_label = $"Value"

func _ready() -> void:
	var value = Config.config.get_value(section, key)
	slider.value = value
	value_label.text = "[%s]%%" % (int)(value * 100)

func value_changed(value):
	value_label.text = "[%s]%%" % (int)(value * 100)

func drag_ended(_changed: bool) -> void:
	Config.config.set_value(section, key, slider.value)
	Config.config.save("user://config.ini")
