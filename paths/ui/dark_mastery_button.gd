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
@export var subject: String
@export var tag: String
@export var extras: Array

var description_scene = preload("res://ui/description.tscn")
var description_nodes: Array

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
			if description_nodes.size() > 0:
				description_nodes[0].set_tag(tag)

## from described
func get_description_title(what):
	return tr(what+"_title")

func get_description_text(what):
	var description = tr(what+"_description")
	if InputMap.has_action(what):
		description = description.format({"keybind": tr("[%s]" % InputMap.action_get_events(what)[0].as_text())})
	return description

func make_description(description_title, description_text, description_tag, description_position):
	var description_instance = description_scene.instantiate()
	ui.add_child(description_instance)
	
	description_instance.position = description_position
	
	description_instance.set_title(description_title)
	description_instance.set_description(description_text)
	description_instance.set_tag(description_tag)
	
	description_nodes.append(description_instance)
	return description_instance

func _on_mouse_entered() -> void:
	if not accessible:
		return
	var winsize = get_window().content_scale_size ## horrible and evil solutions
	var ratio = float(get_window().size.x)/get_window().size.y
	if ratio > float(winsize.x)/winsize.y:
		winsize.x = winsize.y * ratio
	elif ratio < float(winsize.x)/winsize.y:
		winsize.y = winsize.x / ratio
	
	var description_position = Vector2(640, 16)
	var direction = -1
	#if global_position.x + size.x * 0.5 > winsize.x * 0.5:
		#description_position = Vector2(20, 16)
		#direction = 1
	description_position.x += (winsize.x - get_window().content_scale_size.x) * 0.5
	make_description(get_description_title(subject), get_description_text(subject), tag, description_position)
	for extra in extras:
		description_position += Vector2(260 * direction, 0)
		make_description(get_description_title(extra), get_description_text(extra), "", description_position)

func _on_mouse_exited() -> void:
	for description_node in description_nodes:
		description_node.disappear()
	description_nodes.clear()
