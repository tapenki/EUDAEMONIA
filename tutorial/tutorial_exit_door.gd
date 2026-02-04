extends Door

func enter():
	super()
	get_node("/root/Main/Saver").tutorial_complete = true
	get_node("/root/Main/Saver").write_meta()
	get_tree().change_scene_to_file.call_deferred("res://main_game.tscn")
