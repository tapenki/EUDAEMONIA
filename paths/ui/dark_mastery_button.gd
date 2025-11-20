extends TextureButton

@onready var ui = get_node("/root/Main/UI")
@onready var player = get_node("/root/Main/UI").player
@onready var ability_handler = player.get_node("AbilityHandler")

@onready var texture_rect1: = $"TextureRect1"
@onready var texture_rect2: = $"TextureRect2"
@onready var symbol_label: = $"Symbol"

@export var accessible_texture: Texture2D
@export var requires: Dictionary

## from described
@onready var description = get_node("/root/Main/UI/Description")
@onready var description_title = description.get_node("Title")
@onready var description_tag = description_title.get_node("Tag")

@export var subject: String
@export var tag: String

var accessible: bool

func _ready() -> void:
	ability_handler.update_abilities.connect(update)
	update()

func update():
	var passed = true
	for ability in requires:
		var ability_node = ability_handler.get_node_or_null(ability)
		if not ability_node or ability_node.level < requires[ability]:
			passed = false
			break
	
	if passed:
		texture_rect1.texture = accessible_texture
		texture_rect2.texture = accessible_texture
		symbol_label.text = name.substr(0, 2)
		accessible = true
		var ability_node = ability_handler.get_node_or_null(subject)
		if ability_node:
			texture_rect1.self_modulate = Color.WHITE
			texture_rect2.self_modulate = Color.WHITE
			symbol_label.self_modulate = Color.WHITE
			tag = "learned"

func _on_pressed() -> void:
	if not get_node("/root/Main").game_over and accessible:
		var ability_node = ability_handler.get_node_or_null(subject)
		if not ability_node:
			ability_handler.upgrade("dark_price", 32)
			ability_handler.upgrade(subject, 1)
			texture_rect1.self_modulate = Color.WHITE
			texture_rect2.self_modulate = Color.WHITE
			symbol_label.self_modulate = Color.WHITE
			tag = "Learned"
			description_tag.text = tag

## from described
func _on_mouse_entered() -> void:
	if not accessible:
		return
	description.set_title(subject+"_title")
	description.set_description(subject+"_description")
	description.set_tag(tag)
	
	description.positionize(global_position + Vector2(size.x - description.size.x, size.y) * 0.5)
	description.visible = true

func _on_mouse_exited() -> void:
	description.visible = false
