class_name UnlockPathButton extends Described

@onready var upgrades_ui = $"../../../"
@onready var picker = $"../../"

@onready var point_counter = $"../../../UpgradePoints"

@onready var symbol_label: = $"Symbol"

var enabled = true

func _ready() -> void:
	symbol_label.text = name.substr(0, 2)

func _on_pressed() -> void:
	if enabled and not get_node("/root/Main").game_over and ui.unlock_points >= 1:
		ui.unlock_points -= 1
		point_counter.update()
		ui.paths.append(subject)
		picker.pick(subject)
		get_node("/root/Main").play_sound("Click")
	else:
		get_node("/root/Main").play_sound("Error")

func disable():
	modulate = Color(0.125, 0.125, 0.125)
	tag = "learned"
	enabled = false
