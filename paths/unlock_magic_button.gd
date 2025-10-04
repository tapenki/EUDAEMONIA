extends Described

@onready var ui = get_node("/root/Main/UI")

@onready var upgrades_ui = $"../../../"
@onready var picker = $"../../"

@onready var point_counter = $"../../../UpgradePoints"

@onready var symbol_label: = $"Symbol"

func _ready() -> void:
	#rotation_degrees = randf_range(-5, 5)
	symbol_label.text = name.substr(0, 2)

func _on_pressed() -> void:
	if not ui.defeated and ui.unlock_points >= 1:
		ui.unlock_points -= 1
		point_counter.update(0)
		ui.paths.append(subject)
		picker.pick(subject)
