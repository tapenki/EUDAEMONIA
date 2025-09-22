extends Control

@onready var ui = $"../../../"

@onready var grid = $"GridContainer"

@export var next: Node

func reveal():
	visible = true
	for button in grid.get_children():
		if ui.paths.has(button.subject):
			button.visible = false
