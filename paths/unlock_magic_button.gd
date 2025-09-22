extends Described

@onready var ui = $"../../../../../"

@onready var upgrades_ui = $"../../../"
@onready var picker = $"../../"

@onready var point_counter = $"../../../Level"

@onready var level_label: = $"Level"
@onready var symbol_label: = $"Symbol"

@export var path_scene: PackedScene

func _ready() -> void:
	#rotation_degrees = randf_range(-5, 5)
	symbol_label.text = subject.substr(0, 2)

func _on_pressed() -> void:
	if ui.upgrade_points >= 1:
		ui.upgrade_points -= 1
		point_counter.update(0)
		ui.paths.append(subject)
		var path_instance = path_scene.instantiate()
		path_instance.position = picker.position
		upgrades_ui.add_child(path_instance)
		if picker.next:
			picker.next.reveal()
		picker.queue_free()
