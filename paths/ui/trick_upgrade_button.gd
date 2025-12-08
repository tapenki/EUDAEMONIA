extends Described

@onready var player = get_node("/root/Main/UI").player
@onready var ability_handler = player.get_node("AbilityHandler")

@onready var point_counter = $"../../../UpgradePoints"

@onready var level_label: = $"Level"
@onready var symbol_label: = $"Symbol"
@onready var keybind_button: = $"Bind"

var on = preload("res://ui/button_blue.png")
var off = preload("res://ui/button.png")

func _ready() -> void:
	set_process_input(false)
	#rotation_degrees = randf_range(-5, 5)
	symbol_label.text = name.substr(0, 2)
	keybind_button.text = "[%s]" % InputMap.action_get_events(subject)[0].as_text()
	var ability_node = ability_handler.get_node_or_null(subject)
	if ability_node:
		self_modulate = Color.WHITE
		symbol_label.self_modulate = Color.WHITE
		level_label.text = "[%s]" % int(ability_node.level)
		keybind_button.visible = true

func _on_pressed() -> void:
	if not get_node("/root/Main").game_over and ui.upgrade_points >= 1:
		ui.upgrade_points -= 1
		ability_handler.upgrade(subject, 1)
		point_counter.update()
		var ability_node = ability_handler.get_node_or_null(subject)
		if ability_node:
			self_modulate = Color.WHITE
			symbol_label.self_modulate = Color.WHITE
			level_label.text = "[%s]" % int(ability_node.level)
			keybind_button.visible = true

func toggle_keybind_input(toggled_on: bool) -> void:
	set_process_input(toggled_on)
	if toggled_on:
		ui.cancel_keybind()
		ui.keybind_setting = self
		keybind_button.get_node("NinePatchRect").texture = on
	else:
		keybind_button.get_node("NinePatchRect").texture = off
		ui.keybind_setting = null

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		InputMap.action_erase_event(subject, InputMap.action_get_events(subject)[0])
		var new_event = InputEventKey.new()
		new_event.keycode = event.keycode
		InputMap.action_add_event(subject, event)
		Config.config.set_value("keyboard_controls", subject, [0, event.keycode])
		Config.config.save("user://config.ini")
		keybind_button.text = "[%s]" % new_event.as_text()
		keybind_button.button_pressed = false
		get_viewport().set_input_as_handled()
	if event is InputEventMouseButton and event.pressed:
		InputMap.action_erase_event(subject, InputMap.action_get_events(subject)[0])
		var new_event = InputEventMouseButton.new()
		new_event.button_index = event.button_index
		InputMap.action_add_event(subject, new_event)
		Config.config.set_value("keyboard_controls", subject, [1, event.button_index])
		Config.config.save("user://config.ini")
		keybind_button.text = "[%s]" % new_event.as_text()
		keybind_button.button_pressed = false
		get_viewport().set_input_as_handled()
