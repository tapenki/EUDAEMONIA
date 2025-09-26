extends Node

@export var player: Entity

@onready var main = get_node("/root/Main")

@onready var fade = $"TransitionFade"
@onready var backdrop = $"Backdrop"

@onready var proceed = $"Control/Proceed"
@onready var upgrades = $"Control/UpgradeScreen"

var defeated: bool

var upgrade_points = 10
var unlock_points = 2
var paths: Array

func _ready() -> void:
	var magic_picker = upgrades.get_node("MagicPicker1")
	for path in paths:
		magic_picker.pick(path)
		magic_picker = magic_picker.next
	fade.color = Color(0,0,0)
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0,0,0,0), 0.4)
	main.day_cleared.connect(day_cleared)
	player.ability_handler.self_death.connect(defeat)
	toggle_pause(true)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		toggle_upgrades()

func toggle_pause(pause):
	get_tree().paused = pause

func toggle_upgrades():
	if upgrades.visible:
		upgrades.visible = false
		backdrop.visible = false
		if not defeated:
			proceed.visible = false
		if main.day_over:
			main.start_day()
		toggle_pause(false)
	else:
		upgrades.visible = true
		backdrop.visible = true
		if main.day_over:
			main.end_day()
			proceed.text = "start_day"
		elif not defeated:
			proceed.visible = true
			proceed.text = "continue"
		toggle_pause(true)
	fade.color = Color(0,0,0)
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0,0,0,0), 0.2)

func defeat():
	proceed.visible = true
	proceed.text = "menu"
	get_node("Control/Defeated").visible = true
	defeated = true

func day_cleared(_day) -> void:
	proceed.visible = true
	proceed.text = "end_day"

func reset():
	Saver.erase()
	get_tree().reload_current_scene()
