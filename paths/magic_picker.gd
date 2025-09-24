extends Control

@onready var ui = $"../../../"

@onready var grid = $"GridContainer"

@export var next: Node

func pick(path):
	var path_instance = AbilityData.path_data[path]["scene"].instantiate()
	path_instance.position = position
	add_sibling(path_instance)
	queue_free()
	if next:
		next.reveal()

func reveal():
	visible = true
	for button in grid.get_children():
		if ui.paths.has(button.subject):
			button.visible = false
