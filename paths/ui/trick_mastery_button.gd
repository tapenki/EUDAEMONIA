extends Described

@onready var player = get_node("/root/Main/UI").player
@onready var ability_relay = player.get_node("AbilityRelay")

@onready var point_counter = get_node("/root/Main/UI/GameMenu/UpgradePoints")

@onready var texture_rect1: = $"TextureRect1"
@onready var texture_rect2: = $"TextureRect2"
@onready var symbol_label: = $"Symbol"
@onready var keybind_button: = $"Bind"

@export var accessible_texture: Texture2D
@export var requires: Dictionary

## keybind button textures
var on = preload("res://ui/button_blue.png")
var off = preload("res://ui/button.png")

var accessible: bool

func _ready() -> void:
	set_process_input(false)
	get_node("/root/Main/PlayerAbilityHandler").abilities_changed.connect(update)
	update()
	Utils.controls_changed.connect(controls_changed)
	controls_changed(subject)

func update():
	var passed = true
	for ability in requires:
		var ability_node = get_node_or_null("/root/Main/PlayerAbilityHandler/"+ability)
		if not ability_node or ability_node.level < requires[ability]:
			passed = false
			break
	
	if passed:
		texture_rect1.texture = accessible_texture
		texture_rect2.texture = accessible_texture
		symbol_label.text = name.substr(0, 2)
		accessible = true
		var ability_node = get_node_or_null("/root/Main/PlayerAbilityHandler/"+subject)
		if ability_node:
			texture_rect1.self_modulate = Color.WHITE
			texture_rect2.self_modulate = Color.WHITE
			symbol_label.self_modulate = Color.WHITE
			tag = "learned"
			keybind_button.visible = true

func _on_pressed() -> void:
	if not get_node("/root/Main").game_over and accessible and ui.unlock_points >= 1:
		var ability_node = get_node_or_null("/root/Main/PlayerAbilityHandler/"+subject)
		if not ability_node:
			ui.unlock_points -= 1
			get_node("/root/Main/PlayerAbilityHandler").learn(subject, 1)
			point_counter.update()
			texture_rect1.self_modulate = Color.WHITE
			texture_rect2.self_modulate = Color.WHITE
			symbol_label.self_modulate = Color.WHITE
			tag = "Learned"
			if description_nodes.size() > 0:
				description_nodes[0].set_tag(tag)
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

func _on_mouse_entered() -> void:
	if accessible:
		super()

func controls_changed(action):
	if action == subject:
		keybind_button.text = "[%s]" % InputMap.action_get_events(subject)[0].as_text()
	for description_node in description_nodes:
		if action == description_node.subject:
			description_node.set_description(get_description_text(description_node.subject))
