class_name Described extends Control

@onready var description = get_node("/root/Main/UI/Description")
@onready var description_title = description.get_node("Title")
@onready var description_tag = description_title.get_node("Tag")

@export var subject: String
@export var tag: String

func get_title():
	return tr(subject+"_title")

func get_description():
	return tr(subject+"_description")

func _on_mouse_entered() -> void:
	description_title.text = get_title()
	description.text = get_description()
	if tag != "":
		description_tag.text = tag
		description_tag.visible = true
	else:
		description_tag.visible = false
	
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
