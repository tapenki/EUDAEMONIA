extends Node

func erase():
	var save_file = FileAccess.open("user://run_save", FileAccess.WRITE)
	save_file.store_var({"version" : ""})

func write():
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

func read():
	if not FileAccess.file_exists("user://run_save"):
		return
	var save_file = FileAccess.open("user://run_save", FileAccess.READ)
	var save_data = save_file.get_var()
	if save_data["version"] != ProjectSettings.get_setting("application/config/version"):
		return
	get_node("/root/Main").day = save_data["day"]
	get_node("/root/Main").room = save_data["room"]
	get_node("/root/Main").door = save_data["door"]
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

func _ready():
	read()
