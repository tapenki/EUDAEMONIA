class_name UICore extends Node

@onready var main = get_node("/root/Main")
@onready var saver = get_node("/root/Main/Saver")

@onready var settings = $"Settings"
@onready var settings_tab = $"Settings/General"
@onready var settings_tab_button = $"Settings/TopRightButtons/ToGeneral"

var keybind_setting: Node

func transition(duration = 0.2):
	var fade_instance = ColorRect.new()
	fade_instance.set_anchors_preset(Control.PRESET_FULL_RECT)
	fade_instance.z_index = 25
	fade_instance.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fade_instance.color = Color(0,0,0)
	add_child(fade_instance)
	var tween = create_tween()
	tween.tween_property(fade_instance, "color", Color(0,0,0,0), duration)

func _ready() -> void:
	transition(0.4)

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
	transition()
	get_node("/root/Main").play_sound("Click")

func toggle_pause(pause):
	get_tree().paused = pause
