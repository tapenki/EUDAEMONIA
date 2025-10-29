extends Button

@onready var ui = $"../../"

func _ready() -> void:
	get_node("/root/Main").day_cleared.connect(day_cleared)

func _on_pressed() -> void:
	ui.toggle_upgrades()

func day_cleared(_day) -> void:
	visible = true
	text = "end_day"
