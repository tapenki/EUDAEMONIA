class_name Described extends Control

@onready var primary_description = get_node("/root/Main/UI/PrimaryDescription")
@onready var secondary_description = get_node("/root/Main/UI/SecondaryDescription")
var current_description: Node

@export var subject: String
@export var tag: String

func get_title():
	return tr(subject+"_title")

func get_description():
	return tr(subject+"_description")

func _on_mouse_entered() -> void:
	if primary_description.locked and primary_description.visible:
		secondary_description.describe(self)
	else:
		primary_description.describe(self)

func _on_mouse_exited() -> void:
	if current_description and not current_description.locked:
		current_description.undescribe()
