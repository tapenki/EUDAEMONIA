class_name Described extends Control

@onready var description = get_node("/root/Main/UI/Description")
@onready var description_title = description.get_node("Title")
@onready var description_extra = description_title.get_node("Extra")

@export var subject: String
@export var extra: String

func _on_mouse_entered() -> void:
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
	
	var name_offset = description_title.get_content_height() + 18
	var description_offset = description.get_content_height() + 6
	description.global_position = (global_position + Vector2(size.x - description.size.x, size.y) * 0.5).clamp(Vector2(6, name_offset), Vector2(900 - 306, 600 - description_offset))
	
	description.visible = true

func _on_mouse_exited() -> void:
	description.visible = false
