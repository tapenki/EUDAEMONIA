extends Label

@export var action: String

@onready var ui = $"../../.."
@onready var keybind_button = $"Bind"
@onready var rect = $"Bind/NinePatchRect"

var on = preload("res://ui/button_blue.png")
var off = preload("res://ui/button.png")

func _ready() -> void:
	set_process_unhandled_input(false)
	keybind_button.text = "[%s]" % InputMap.action_get_events(action)[0].as_text()

func toggle(toggled_on: bool) -> void:
	set_process_unhandled_input(toggled_on)
	if toggled_on:
		ui.cancel_keybind()
		ui.keybind_setting = self
		rect.texture = on
	else:
		rect.texture = off
		ui.keybind_setting = null

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		InputMap.action_erase_event(action, InputMap.action_get_events(action)[0])
		InputMap.action_add_event(action, event)
		Config.config.set_value("keybinds", action, event.keycode)
		Config.config.save("user://config.ini")
		keybind_button.text = "[%s]" % event.as_text()
		keybind_button.button_pressed = false
		get_viewport().set_input_as_handled()
