extends TextureButton

@onready var ui = get_node("/root/Main/UI")
@onready var player = get_node("/root/Main/UI").player
@onready var ability_handler = player.get_node("AbilityHandler")

@onready var point_counter = $"../../../UpgradePoints"

@onready var texture_rect1: = $"TextureRect1"
@onready var texture_rect2: = $"TextureRect2"
@onready var symbol_label: = $"Symbol"

@export var accessible_texture: Texture2D
@export var requires: Dictionary

## from described
@onready var primary_description = get_node("/root/Main/UI/PrimaryDescription")
@onready var secondary_description = get_node("/root/Main/UI/SecondaryDescription")
var current_description: Node

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
	if not get_node("/root/Main").game_over and accessible and ui.unlock_points >= 1:
		var ability_node = ability_handler.get_node_or_null(subject)
		if not ability_node:
			ui.unlock_points -= 1
			ability_handler.upgrade(subject, 1)
			point_counter.update()
			texture_rect1.self_modulate = Color.WHITE
			texture_rect2.self_modulate = Color.WHITE
			symbol_label.self_modulate = Color.WHITE
			tag = "Learned"
			if current_description:
				current_description.set_tag(tag)

## from described
func get_title():
	return tr(subject+"_title")

func get_description():
	return tr(subject+"_description")
	
func _on_mouse_entered() -> void:
	if not accessible:
		return
	if primary_description.locked and primary_description.visible:
		secondary_description.describe(self)
	else:
		primary_description.describe(self)

func _on_mouse_exited() -> void:
	if current_description and not current_description.locked:
		current_description.undescribe()
