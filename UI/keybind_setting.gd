extends Label

@export var action: String

@onready var ui = $"../../.."
@onready var bind = $"Bind"
@onready var rect = $"Bind/NinePatchRect"

var on = preload("res://UI/button_blue.png")
var off = preload("res://UI/button.png")

func _ready() -> void:
	set_process_unhandled_key_input(false)
	bind.text = "[%s]" % InputMap.action_get_events(action)[0].as_text()

func toggle(toggled_on: bool) -> void:
	set_process_unhandled_key_input(toggled_on)
	if toggled_on:
		if ui.keybind_setting:
			ui.keybind_setting.bind.button_pressed = false
		ui.keybind_setting = self
		rect.texture = on
	else:
		rect.texture = off
		ui.keybind_setting = null

func _unhandled_key_input(event: InputEvent) -> void:
	if event.pressed:
		InputMap.action_erase_event(action, InputMap.action_get_events(action)[0])
		InputMap.action_add_event(action, event)
		Config.config.set_value("keybinds", action, event.keycode)
		Config.config.save("user://config.ini")
		bind.text = "[%s]" % event.as_text()
		bind.button_pressed = false
		get_viewport().set_input_as_handled()
