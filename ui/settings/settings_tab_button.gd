extends Button

@onready var ui = $"../.."
@onready var rect = $"NinePatchRect"

@export var tab : Node

var on = preload("res://ui/button_blue.png")
var off = preload("res://ui/button.png")

func pressed() -> void:
	if ui.settings_tab != tab:
		ui.settings_tab.visible = false
		ui.settings_tab_button.rect.texture = ui.settings_tab_button.off
		ui.settings_tab = tab
		ui.settings_tab_button = self
		tab.visible = true
		rect.texture = on
		ui.cancel_keybind()
		get_node("/root/Main").play_sound("Click")
