extends Label

@export var section : String
@export var key : String

@onready var checkbox = $"CheckBox"

func _ready() -> void:
	var value = Config.config.get_value(section, key)
	checkbox.button_pressed = value

func toggle(toggled_on: bool) -> void:
	Config.config.set_value(section, key, toggled_on)
	Config.config.save("user://config.ini")
