extends Button

var button_blue = preload("res://ui/button_blue.png")
var button_gray = preload("res://ui/button.png")

@export var tab: Node

func _ready() -> void:
	get_node("/root/Main/UI").switch_game_menu_tab.connect(update)

func update(updated_tab):
	if tab == updated_tab:
		get_node("NinePatchRect").texture = button_blue
	else:
		get_node("NinePatchRect").texture = button_gray

func _on_pressed() -> void:
	get_node("/root/Main/UI").switch_game_menu_tab.emit(tab)
	get_node("/root/Main").play_sound("Click")
