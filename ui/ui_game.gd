extends UICore

@export var player: Entity

@onready var backdrop = $"Backdrop"

var button_red = preload("res://ui/button_red.png")
var button_blue = preload("res://ui/button_blue.png")
var button_gray = preload("res://ui/button.png")

@onready var proceed = $"HUD/Proceed"
@onready var game_menu = $"GameMenu"
@onready var reset_button = $"GameMenu/Reset"
@onready var hud = $"HUD"

#var weapon = "magic_missile"
#var armor = "hermits_cloak"
var challenges: Array

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

func _process(_delta: float) -> void:
	if main.game_over:
		if not game_menu.visible and Time.get_ticks_msec() % 400 < 200:
			proceed.get_node("NinePatchRect").texture = button_blue
		else:
			proceed.get_node("NinePatchRect").texture = button_gray
		if Time.get_ticks_msec() % 400 < 200:
			reset_button.get_node("NinePatchRect").texture = button_blue
		else:
			reset_button.get_node("NinePatchRect").texture = button_red

func _unhandled_input(event) -> void:
	##is_action_just_pressed_by_event doesn't work with mouse buttons :(
	if Input.is_action_just_pressed("pause") and event.is_action("pause"): 
		if settings.visible:
			toggle_settings()
			return
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
	get_node("/root/Main").play_sound("Click")
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
	get_tree().change_scene_to_file("res://main_menu.tscn")
