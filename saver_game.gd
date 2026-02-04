extends Node

var tutorial_complete: bool

var starter_abilities = {"magic_missile" : {"level" : 1}}

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
	get_node("/root/Main/UI").challenges = save_data.get("challenges", [])

func erase_run():
	var save_file = FileAccess.open("user://run_save", FileAccess.WRITE)
	save_file.store_var({"version" : ""})

func write_run():
	if get_node("/root/Main").game_over:
		return
	var save_data = {
		"version" : ProjectSettings.get_setting("application/config/version"),
		"day" : get_node("/root/Main").day,
		"room" : get_node("/root/Main").room,
		"door" : get_node("/root/Main").door,
		"unlock_points" : get_node("/root/Main/UI").unlock_points,
		"upgrade_points" : get_node("/root/Main/UI").upgrade_points,
		"paths" : get_node("/root/Main/UI").paths,
		"abilities" : {},
	}
	for ability in get_node("/root/Main/Entities/Player/AbilityHandler").get_children():
		if AbilityData.ability_data[ability.name]["type"] != "status":
			save_data["abilities"][ability.name] = ability.serialize()
	var save_file = FileAccess.open("user://run_save", FileAccess.WRITE)
	save_file.store_var(save_data)

func read_run():
	Engine.time_scale = 1.0 ## reset era wink time scale
	if not FileAccess.file_exists("user://run_save"):
		return false
	var save_file = FileAccess.open("user://run_save", FileAccess.READ)
	var save_data = save_file.get_var()
	if save_data["version"] != ProjectSettings.get_setting("application/config/version"):
		return false
	get_node("/root/Main").day = save_data["day"]
	get_node("/root/Main").room = save_data["room"]
	get_node("/root/Main").door = save_data["door"]
	#get_node("/root/Main/UI").toggle_main_menu()
	get_node("/root/Main/UI").unlock_points = save_data["unlock_points"]
	get_node("/root/Main/UI").upgrade_points = save_data["upgrade_points"]
	for path in save_data["paths"]:
		get_node("/root/Main/UI").paths.append(path)
	for ability in save_data["abilities"]:
		var ability_node = Node2D.new()
		ability_node.set_script(AbilityData.ability_data[ability]["script"])
		ability_node.deserialize(save_data["abilities"][ability])
		ability_node.name = ability
		get_node("/root/Main/Entities/Player/AbilityHandler").add_child(ability_node)
	return true

func _ready():
	read_meta()
	if not read_run():
		for ability in starter_abilities:
			var ability_node = Node2D.new()
			ability_node.set_script(AbilityData.ability_data[ability]["script"])
			ability_node.deserialize(starter_abilities[ability])
			ability_node.name = ability
			get_node("/root/Main/Entities/Player/AbilityHandler").add_child(ability_node)
		for challenge in get_node("/root/Main/UI").challenges:
			var ability_node = Node2D.new()
			ability_node.set_script(AbilityData.ability_data[challenge]["script"])
			ability_node.name = challenge
			get_node("/root/Main/Entities/Player/AbilityHandler").add_child(ability_node)
