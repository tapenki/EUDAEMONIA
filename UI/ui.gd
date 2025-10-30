extends Node

@export var player: Entity

@onready var main = get_node("/root/Main")

@onready var fade = $"TransitionFade"
@onready var backdrop = $"Backdrop"

@onready var proceed = $"HUD/Proceed"
@onready var game_menu = $"GameMenu"

@onready var settings = $"Settings"
@onready var settings_tab = $"Settings/General"
@onready var settings_tab_button = $"Settings/ToGeneral"

var keybind_setting: Node

var upgrade_points = 100
var unlock_points = 100
var paths: Array

func _ready() -> void:
	var magic_picker = game_menu.get_node("MagicPicker1")
	for path in paths:
		magic_picker.pick(path)
		magic_picker = magic_picker.next
	fade.color = Color(0,0,0)
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0,0,0,0), 0.4)
	main.intermission.connect(intermission)
	player.ability_handler.self_death.connect(defeat)
	toggle_pause(true)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed_by_event("pause", event):
		if settings.visible:
			toggle_settings()
		else:
			toggle_game_menu()

func toggle_pause(pause):
	get_tree().paused = pause

func toggle_game_menu():
	cancel_keybind()
	if game_menu.visible:
		game_menu.visible = false
		backdrop.visible = false
		if not main.game_over:
			proceed.visible = false
		if not main.day_started:
			main.start_day()
		toggle_pause(false)
	else:
		game_menu.visible = true
		backdrop.visible = true
		proceed.visible = true
		if not main.day_started:
			proceed.text = "start_day"
		elif not main.game_over:
			proceed.text = "continue"
		toggle_pause(true)
	fade.color = Color(0,0,0)
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0,0,0,0), 0.2)

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

func defeat():
	proceed.visible = true
	proceed.text = "menu"
	get_node("HUD/Defeated").visible = true

func intermission(_day) -> void:
	if not game_menu.visible:
		toggle_game_menu()
	proceed.text = "start_day"

func reset():
	Saver.erase()
	get_tree().reload_current_scene()
