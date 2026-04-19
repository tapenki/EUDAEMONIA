extends Label

@export var action: String

@onready var ui = $"../../.."
@onready var keybind_button = $"Bind"
@onready var rect = $"Bind/NinePatchRect"

var on = preload("res://ui/button_blue.png")
var off = preload("res://ui/button.png")

func _ready() -> void:
	set_process_input(false)
	Utils.controls_changed.connect(controls_changed)
	controls_changed(action)

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
		Utils.set_keybind(action, event.keycode)
		keybind_button.button_pressed = false
		get_viewport().set_input_as_handled()
		get_node("/root/Main").play_sound("Click")
	if event is InputEventMouseButton and event.pressed:
		Utils.set_mousebind(action, event.button_index)
		keybind_button.button_pressed = false
		get_viewport().set_input_as_handled()
		get_node("/root/Main").play_sound("Click")

func controls_changed(update_action):
	if update_action == action:
		keybind_button.text = "[%s]" % InputMap.action_get_events(action)[0].as_text()
