extends Button

@onready var ui = $"../.."

func pressed() -> void:
	ui.toggle_settings()
	get_node("/root/Main").play_sound("Click")
