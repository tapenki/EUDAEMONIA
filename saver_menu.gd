extends Node

var tutorial_complete: bool

func write_meta():
	var save_data = {
		"tutorial_complete" : tutorial_complete,
		#"weapon" : get_node("/root/Main/UI").weapon,
		#"armor" : get_node("/root/Main/UI").armor,
		"challenges" : get_node("/root/Main/UI").challenges,
	}
	var save_file = FileAccess.open("user://meta_save", FileAccess.WRITE)
	save_file.store_var(save_data)

func read_meta():
	if not FileAccess.file_exists("user://meta_save"):
		return
	var save_file = FileAccess.open("user://meta_save", FileAccess.READ)
	var save_data = save_file.get_var()
	tutorial_complete = save_data.get("tutorial_complete", false)
	#if AbilityData.ability_data.has(save_data["weapon"]):
	#	get_node("/root/Main/UI").weapon = save_data["weapon"]
	#if AbilityData.ability_data.has(save_data["armor"]):
	#	get_node("/root/Main/UI").armor = save_data["armor"]
	get_node("/root/Main/UI").challenges = save_data.get(["challenges"], [])

func read_run():
	if not FileAccess.file_exists("user://run_save"):
		return false
	var save_file = FileAccess.open("user://run_save", FileAccess.READ)
	var save_data = save_file.get_var()
	if save_data["version"] != ProjectSettings.get_setting("application/config/version"):
		return false
	if tutorial_complete:
		get_tree().change_scene_to_file.call_deferred("res://main_game.tscn")
	else:
		get_tree().change_scene_to_file.call_deferred("res://tutorial/tutorial_game.tscn")
	return true

func _ready():
	read_meta()
	read_run()
