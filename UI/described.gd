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
	description.set_title(get_title())
	description.set_description(get_description())
	description.set_tag(tag)
	
	description.positionize(global_position + Vector2(size.x - description.size.x, size.y) * 0.5)
	description.visible = true

func _on_mouse_exited() -> void:
	description.visible = false
