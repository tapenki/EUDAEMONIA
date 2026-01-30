extends Button

@onready var ui = $"../.."

func pressed() -> void:
	ui.toggle_settings()
