extends Node

var base_values = {
	"gameplay" :
	{
		"damage_numbers" = true,
		"screenshake" = 1.0,
	},
	"audio" : {
		"master_volume" = 1,
		"music_volume" = 1,
		"sfx_volume" = 1,
	},
	"palette" : {
		"1/primary" = "0080ff",
		"1/secondary" = "00c0ff",
		"1/tertiary" = "00ff00",
		"2/primary" = "ff0000",
		"2/secondary" = "ff0080",
		"2/tertiary" = "ff00ff",
		"3/primary" = "ffaa00",
		"3/secondary" = "ffcc00",
		"3/tertiary" = "ffff00",
	},
	"keybinds" : {
		"up" : KEY_W,
		"down" : KEY_S,
		"left" : KEY_A,
		"right" : KEY_D,
		"pause" : KEY_ESCAPE,
		"dark_harvest" : KEY_E,
	}
}

var config = ConfigFile.new()

func _init() -> void:
	var loaded = config.load("user://config.ini")
	var should_save: bool
	for section in base_values:
		for key in base_values[section]:
			if loaded != OK or not config.has_section_key(section, key):
				config.set_value(section, key, base_values[section][key])
				should_save = true
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), config.get_value("audio", "master_volume", 1))
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), config.get_value("audio", "music_volume", 1))
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), config.get_value("audio", "sfx_volume", 1))
	
	for action in config.get_section_keys("keybinds"):
		var input_event = InputEventKey.new()
		input_event.keycode = config.get_value("keybinds", action)
		InputMap.action_add_event(action, input_event)
	
	if should_save:
		config.save("user://config.ini")

func get_team_color(team: int, denominator: String):
	var key = "%s/%s" % [team, denominator]
	return Color(config.get_value("palette", key, "ffffff"))
