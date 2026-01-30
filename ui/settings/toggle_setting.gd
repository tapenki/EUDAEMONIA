extends Label

@export var section : String
@export var key : String

@onready var checkbox = $"CheckBox"

func _ready() -> void:
	var value = Config.config.get_value(section, key)
	checkbox.set_pressed_no_signal(value)

func toggle(toggled_on: bool) -> void:
	Config.config.set_value(section, key, toggled_on)
	Config.config.save("user://config.ini")
	get_node("/root/Main").play_sound("Click")
