extends Control

@onready var ui = get_node("/root/Main/UI")

@export var next: Node
@export var blink: bool

func _process(_delta: float) -> void:
	if blink and Time.get_ticks_msec() % 400 < 200:
		get_node("Label").label_settings.outline_color = Color(0.0, 0.25, 1.0, 1.0)
	else:
		get_node("Label").label_settings.outline_color = Color(0.25, 0.25, 0.25, 1.0)

func pick(path):
	var path_instance = AbilityData.path_data[path]["scene"].instantiate()
	path_instance.position = position
	add_sibling(path_instance)
	queue_free()
	if next:
		next.reveal()

func reveal():
	visible = true
	for child in get_children():
		for button in child.get_children():
			if button is UnlockPathButton and ui.paths.has(button.subject):
				button.disable()
