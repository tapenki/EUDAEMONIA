extends Control

@onready var ui = get_node("/root/Main/UI")

@export var next: Node

func pick(path):
	var path_instance = AbilityData.path_data[path]["scene"].instantiate()
	path_instance.position = position
	ui.path_ui.add_child(path_instance)
	queue_free()
	if next:
		next.reveal()

func reveal():
	visible = true
	for child in get_children():
		for button in child.get_children():
			if button is UnlockPathButton and ui.paths.has(button.subject):
				button.disable()
