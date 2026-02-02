extends UICore

#var weapon = "magic_missile"
#var armor = "hermits_cloak"
var challenges: Array

func _ready() -> void:
	fade.color = Color(0,0,0)
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0,0,0,0), 0.4)

func _unhandled_input(event) -> void:
	##is_action_just_pressed_by_event doesn't work with mouse buttons :(
	if Input.is_action_just_pressed("pause") and event.is_action("pause"): 
		if settings.visible:
			toggle_settings()
			return
		start_run()

func start_run():
	get_node("/root/Main").play_sound("Click")
	saver.write_meta()
	#player.ability_handler.upgrade("magic_missile", 1)
	#player.ability_handler.upgrade(armor, 1)
	#for i in challenges:
	#	player.ability_handler.upgrade(i, 1)
	if saver.tutorial_complete:
		get_tree().change_scene_to_file("res://main_game.tscn")
	else:
		get_tree().change_scene_to_file("res://tutorial/tutorial_game.tscn")
	#get_node("/root/Main").game_start.emit()
