extends UIGame

#var tutorial_step = 0

#func _ready() -> void:
#	update_abilities.connect(check_step_1)
#	super()

#func toggle_game_menu():
#	if tutorial_step < 2:
#		get_node("/root/Main").play_sound("Error")
#		return
#	elif tutorial_step == 2:
#		tutorial_step = 3
#	super()

#func check_step_1():
#	if tutorial_step == 1:
#		tutorial_step = 2
