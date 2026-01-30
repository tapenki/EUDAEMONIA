class_name UICore extends Node

@onready var main = get_node("/root/Main")
@onready var saver = get_node("/root/Main/Saver")

@onready var settings = $"Settings"
@onready var settings_tab = $"Settings/General"
@onready var settings_tab_button = $"Settings/ToGeneral"

@onready var fade = $"TransitionFade"

var keybind_setting: Node

func _ready() -> void:
	fade.color = Color(0,0,0)
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0,0,0,0), 0.4)

func _unhandled_input(event) -> void:
	##is_action_just_pressed_by_event doesn't work with mouse buttons :(
	if Input.is_action_just_pressed("pause") and event.is_action("pause"): 
		if settings.visible:
			toggle_settings()
			return

func cancel_keybind():
	if keybind_setting:
		keybind_setting.keybind_button.button_pressed = false
		keybind_setting = null

func toggle_settings():
	cancel_keybind()
	if settings.visible:
		settings.visible = false
	else:
		settings.visible = true
	fade.color = Color(0,0,0)
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0,0,0,0), 0.2)
	get_node("/root/Main").play_sound("Click")

func toggle_pause(pause):
	get_tree().paused = pause
