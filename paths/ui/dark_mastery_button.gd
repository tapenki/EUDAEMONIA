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
@onready var description = get_node("/root/Main/UI/Description")
@onready var description_title = description.get_node("Title")
@onready var description_extra = description_title.get_node("Extra")

@export var subject: String
@export var extra: String

var accessible: bool

func _ready() -> void:
	ability_handler.upgraded.connect(update)
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
			extra = "learned"

func _on_pressed() -> void:
	if not get_node("/root/Main").game_over and accessible:
		var ability_node = ability_handler.get_node_or_null(subject)
		if not ability_node:
			ability_handler.upgrade("dark_price", 40)
			ability_handler.upgrade(subject, 1)
			point_counter.update()
			texture_rect1.self_modulate = Color.WHITE
			texture_rect2.self_modulate = Color.WHITE
			symbol_label.self_modulate = Color.WHITE
			extra = "Learned"
			description_extra.text = extra

## from described
func _on_mouse_entered() -> void:
	if not accessible:
		return
	
	description_title.text = subject+"_title"
	description.text = subject+"_description"
	if extra != "":
		description_extra.text = extra
		description_extra.visible = true
	else:
		description_extra.visible = false
	
	description.size = Vector2(240, description.get_content_height())
	description_title.size = Vector2(240, description_title.get_content_height())
	description_title.position.y = -description_title.size.y - 4
	
	var winsize = get_window().content_scale_size ## horrible and evil solutions
	var ratio = float(get_window().size.x)/get_window().size.y
	if ratio > float(winsize.x)/winsize.y:
		winsize.x = winsize.y * ratio
	elif ratio < float(winsize.x)/winsize.y:
		winsize.y = winsize.x / ratio
	
	var name_offset = description_title.get_content_height() + 18
	var description_offset = description.get_content_height() + 6
	description.global_position = (global_position + Vector2(size.x - description.size.x, size.y) * 0.5).clamp(Vector2(6, name_offset), Vector2(winsize.x - 244, winsize.y - description_offset))
	
	description.visible = true

func _on_mouse_exited() -> void:
	description.visible = false
