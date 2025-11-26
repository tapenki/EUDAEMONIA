class_name Described extends Control

@onready var ui = get_node("/root/Main/UI")
@export var subject: String
@export var tag: String
@export var extras: Array

var description_scene = preload("res://ui/description.tscn")
var description_nodes: Array

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
	var winsize = get_window().content_scale_size ## horrible and evil solutions
	var ratio = float(get_window().size.x)/get_window().size.y
	if ratio > float(winsize.x)/winsize.y:
		winsize.x = winsize.y * ratio
	elif ratio < float(winsize.x)/winsize.y:
		winsize.y = winsize.x / ratio
	
	var description_position = Vector2(640, 16)
	var direction = -1
	if global_position.x + size.x * 0.5 > winsize.x * 0.5:
		description_position = Vector2(20, 16)
		direction = 1
	description_position.x += (winsize.x - get_window().content_scale_size.x) * 0.5
	
	make_description(get_description_title(subject), get_description_text(subject), tag, description_position)
	for extra in extras:
		description_position += Vector2(260 * direction, 0)
		make_description(get_description_title(extra), get_description_text(extra), "", description_position)

func _on_mouse_exited() -> void:
	for description_node in description_nodes:
		description_node.disappear()
	description_nodes.clear()
