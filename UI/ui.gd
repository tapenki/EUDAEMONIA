extends Node

@export var player: Entity

@onready var main = get_node("/root/Main")
@onready var saver = get_node("/root/Main/Saver")

@onready var main_menu = $"MainMenu"

@onready var settings = $"Settings"
@onready var settings_tab = $"Settings/General"
@onready var settings_tab_button = $"Settings/ToGeneral"

@onready var fade = $"TransitionFade"
@onready var backdrop = $"Backdrop"

@onready var proceed = $"HUD/Proceed"
@onready var game_menu = $"GameMenu"
@onready var hud = $"HUD"

var keybind_setting: Node

var weapon = "magic_missile"
var armor = "mystic_robes"

var upgrade_points = 1
var unlock_points = 1
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

func _unhandled_input(event) -> void:
	##is_action_just_pressed_by_event doesn't work with mouse buttons :(
	if Input.is_action_just_pressed("pause") and event.is_action("pause"): 
		if settings.visible:
			toggle_settings()
			return
		if main_menu.visible:
			start_run()
		else:
			toggle_game_menu()

func toggle_main_menu():
	if $"MainMenu".visible:
		$"MainMenu".visible = false
		$"MainMenu".process_mode = Node.PROCESS_MODE_DISABLED
		$"GameMenu".visible = true
		$"HUD".visible = true
	$"TransitionFade".color = Color(0,0,0)
	var tween = create_tween()
	tween.tween_property($"TransitionFade", "color", Color(0,0,0,0), 0.4)

func start_run():
	saver.write_meta()
	toggle_main_menu()
	player.ability_handler.grant(weapon, 1)
	player.ability_handler.grant(armor, 1)
	$"GameMenu/Equipment".remload()
	get_node("/root/Main").game_start.emit()

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

func defeat():
	proceed.visible = true
	proceed.text = "menu"
	get_node("HUD/Defeated").visible = true

func intermission(_day) -> void:
	if not game_menu.visible:
		toggle_game_menu()
	proceed.text = "start_day"

func reset():
	saver.erase_run()
	get_tree().reload_current_scene()
