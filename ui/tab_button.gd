extends Button

@export var tab: Node

func _on_pressed() -> void:
	get_node("/root/Main/UI").switch_game_menu_tab(tab)
	get_node("/root/Main").play_sound("Click")
