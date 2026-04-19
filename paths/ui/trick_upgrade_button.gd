extends Described

@onready var player = get_node("/root/Main/UI").player
@onready var ability_relay = player.get_node("AbilityRelay")

@onready var point_counter = get_node("/root/Main/UI/GameMenu/UpgradePoints")

@onready var level_label: = $"Level"
@onready var symbol_label: = $"Symbol"
@onready var keybind_button: = $"Bind"

var on = preload("res://ui/button_blue.png")
var off = preload("res://ui/button.png")

func _ready() -> void:
	set_process_input(false)
	#rotation_degrees = randf_range(-5, 5)
	symbol_label.text = name.substr(0, 2)
	Utils.controls_changed.connect(controls_changed)
	controls_changed(subject)
	var ability_node = get_node_or_null("/root/Main/PlayerAbilityHandler/"+subject)
	if ability_node:
		self_modulate = Color.WHITE
		symbol_label.self_modulate = Color.WHITE
		level_label.text = "[%s]" % int(ability_node.level)
		keybind_button.visible = true

func _on_pressed() -> void:
	if not get_node("/root/Main").game_over and ui.upgrade_points >= 1:
		ui.upgrade_points -= 1
		get_node("/root/Main/PlayerAbilityHandler").learn(subject, 1)
		point_counter.update()
		var ability_node = get_node_or_null("/root/Main/PlayerAbilityHandler/"+subject)
		if ability_node:
			self_modulate = Color.WHITE
			symbol_label.self_modulate = Color.WHITE
			level_label.text = "[%s]" % int(ability_node.level)
			keybind_button.visible = true
		get_node("/root/Main").play_sound("Click")
	else:
		get_node("/root/Main").play_sound("Error")

func toggle_keybind_input(toggled_on: bool) -> void:
	set_process_input(toggled_on)
	if toggled_on:
		ui.cancel_keybind()
		ui.keybind_setting = self
		keybind_button.get_node("NinePatchRect").texture = on
	else:
		keybind_button.get_node("NinePatchRect").texture = off
		ui.keybind_setting = null
	get_node("/root/Main").play_sound("Click")

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		Utils.set_keybind(subject, event.keycode)
		keybind_button.button_pressed = false
		get_viewport().set_input_as_handled()
		get_node("/root/Main").play_sound("Click")
	if event is InputEventMouseButton and event.pressed:
		Utils.set_mousebind(subject, event.button_index)
		keybind_button.button_pressed = false
		get_viewport().set_input_as_handled()
		get_node("/root/Main").play_sound("Click")

func controls_changed(action):
	if action == subject:
		keybind_button.text = "[%s]" % InputMap.action_get_events(subject)[0].as_text()
	for description_node in description_nodes:
		if action == description_node.subject:
			description_node.set_description(get_description_text(description_node.subject))
