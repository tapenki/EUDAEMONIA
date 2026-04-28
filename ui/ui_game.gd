class_name UIGame extends UICore

@export var player: Entity

@onready var backdrop = $"Backdrop"

@onready var game_menu = $"GameMenu"
@onready var hud = $"HUD"

@onready var proceed = $"HUD/Proceed"
@onready var reset_button = $"GameMenu/Reset"

@onready var ability_menu = $"GameMenu/Abilities"
@onready var affect_menu = $"GameMenu/Affects"

@onready var path_pickers = $"GameMenu/Abilities/PathPickers"
@onready var path_ui = $"GameMenu/Abilities/PathUI"

var button_red = preload("res://ui/button_red.png")
var button_blue = preload("res://ui/button_blue.png")
var button_gray = preload("res://ui/button.png")

var upgrade_points: int = 100
var unlock_points: int = 100
var paths: Array

var challenges: Array

@onready var game_menu_tab = $"GameMenu/Abilities"

func _ready() -> void:
	var magic_picker = path_pickers.get_node("MagicPicker1")
	for path in paths:
		magic_picker.pick(path)
		magic_picker = magic_picker.next
	get_node("/root/Main/PlayerAbilityHandler").ability_added.connect(affect)
	for ability in get_node("/root/Main/PlayerAbilityHandler").get_children():
		affect(ability.name)
	fade.color = Color(0,0,0)
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0,0,0,0), 0.4)
	main.intermission.connect(intermission)
	player.ability_relay.self_death.connect(defeat)
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
		hud.get_node("Chat").visible = true
		hud.get_node("Tricks").visible = true
		toggle_pause(false)
	else:
		game_menu.visible = true
		backdrop.visible = true
		proceed.visible = true
		
		if not main.day_started:
			proceed.text = "start_day"
		elif not main.game_over:
			proceed.text = "continue"
		hud.get_node("Chat").visible = false
		hud.get_node("Tricks").visible = false
		toggle_pause(true)
	get_node("/root/Main").play_sound("Click")
	fade.color = Color(0,0,0)
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0,0,0,0), 0.2)

func defeat():
	if Config.config.get_value("gameplay", "auto_restart"):
		reset.call_deferred()
		return
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

func switch_game_menu_tab(tab):
	for button in game_menu.get_node("TabButtons").get_children():
		if button.tab == tab:
			button.get_node("NinePatchRect").texture = button_blue
		else:
			button.get_node("NinePatchRect").texture = button_gray
	game_menu_tab.visible = false
	tab.visible = true
	game_menu_tab = tab

func affect(ability: String):
	if AbilityData.ability_data.has(ability) and (AbilityData.ability_data[ability].has("affect")):
		var reminder_instance = AbilityData.ability_data[ability]["affect"].instantiate()
		reminder_instance.subject = ability
		reminder_instance.name = ability
		affect_menu.get_node("Container").add_child(reminder_instance)

func disaffect(ability: String):
	var reminder_instance = affect_menu.get_node_or_null("Container/"+ability)
	if reminder_instance:
		reminder_instance.queue_free()

func unlearn_all():
	fade.color = Color(0,0,0)
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0,0,0,0), 0.4)
	for entity in get_node("/root/Main/Entities").get_children():
		if not entity is Player:
			entity.ability_relay.freed.emit()
			entity.queue_free()
	for projectile in get_node("/root/Main/Projectiles").get_children():
		projectile.ability_relay.freed.emit()
		projectile.queue_free()
	for effect in get_node("/root/Main/Effects").get_children():
		effect.queue_free()
	for path_node in path_ui.get_children():
		path_node.unlearn()
	for path_picker in path_pickers.get_children():
		path_picker.queue_free()
	paths.clear()
	game_menu.get_node("UpgradePoints").update()
	var path_picker_scene = preload("res://paths/ui/magic_picker.tscn")
	var previous_picker = null
	for i in 4:
		var path_picker_instance = path_picker_scene.instantiate()
		if i > 0:
			path_picker_instance.visible = false
		path_picker_instance.position.x = i * 225
		if previous_picker:
			previous_picker.next = path_picker_instance
		previous_picker = path_picker_instance
		path_pickers.add_child(path_picker_instance)
