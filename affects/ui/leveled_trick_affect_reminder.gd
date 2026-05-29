extends Described

@onready var symbol_label: = $"Symbol"
@onready var keybind_button: = $"Bind"
@onready var level_label: = $"Level"

var on = preload("res://ui/button_blue.png")
var off = preload("res://ui/button.png")

func _ready() -> void:
	set_process_input(false)
	symbol_label.text = subject.substr(0, 2).capitalize()
	Utils.controls_changed.connect(controls_changed)
	get_node_or_null("/root/Main/PlayerAbilityHandler").abilities_changed.connect(abilities_changed)
	controls_changed(subject)
	abilities_changed()

func abilities_changed():
	var ability_node = get_node_or_null("/root/Main/PlayerAbilityHandler/"+subject)
	if ability_node:
		level_label.text = "[%s]" % int(ability_node.level)

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
