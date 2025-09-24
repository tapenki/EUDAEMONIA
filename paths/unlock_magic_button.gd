extends Described

@onready var ui = $"../../../../../"

@onready var upgrades_ui = $"../../../"
@onready var picker = $"../../"

@onready var point_counter = $"../../../UpgradePoints"

@onready var level_label: = $"Level"
@onready var symbol_label: = $"Symbol"

func _ready() -> void:
	#rotation_degrees = randf_range(-5, 5)
	symbol_label.text = subject.substr(0, 2)

func _on_pressed() -> void:
	if ui.upgrade_points >= 1:
		ui.upgrade_points -= 1
		point_counter.update(0)
		ui.paths.append(subject)
		picker.pick(subject)
