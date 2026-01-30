extends Label

@export var action: String

@onready var ui = $"../../.."
@onready var keybind_button = $"Bind"
@onready var rect = $"Bind/NinePatchRect"

var on = preload("res://ui/button_blue.png")
var off = preload("res://ui/button.png")

func _ready() -> void:
	set_process_input(false)
	keybind_button.text = "[%s]" % InputMap.action_get_events(action)[0].as_text()

func toggle(toggled_on: bool) -> void:
	set_process_input(toggled_on)
	if toggled_on:
		ui.cancel_keybind()
		ui.keybind_setting = self
		rect.texture = on
	else:
		rect.texture = off
		ui.keybind_setting = null
	get_node("/root/Main").play_sound("Click")

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		InputMap.action_erase_event(action, InputMap.action_get_events(action)[0])
		var new_event = InputEventKey.new()
		new_event.keycode = event.keycode
		InputMap.action_add_event(action, event)
		Config.config.set_value("keyboard_controls", action, [0, event.keycode])
		Config.config.save("user://config.ini")
		keybind_button.text = "[%s]" % new_event.as_text()
		keybind_button.button_pressed = false
		get_viewport().set_input_as_handled()
		get_node("/root/Main").play_sound("Click")
	if event is InputEventMouseButton and event.pressed:
		InputMap.action_erase_event(action, InputMap.action_get_events(action)[0])
		var new_event = InputEventMouseButton.new()
		new_event.button_index = event.button_index
		InputMap.action_add_event(action, new_event)
		Config.config.set_value("keyboard_controls", action, [1, event.button_index])
		Config.config.save("user://config.ini")
		keybind_button.text = "[%s]" % new_event.as_text()
		keybind_button.button_pressed = false
		get_viewport().set_input_as_handled()
		get_node("/root/Main").play_sound("Click")
