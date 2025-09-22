extends Node

var base_values = {
	"palette" : {
		"1/primary" = "0080ff",
		"1/secondary" = "00c0ff",
		"2/primary" = "ff0000",
		"2/secondary" = "ff0080",
		"3/primary" = "ffcc00",
		"3/secondary" = "ffaa00",
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
	if should_save:
		config.save("user://config.ini")

func get_team_color(team: int, denominator: String):
	var key = "%s/%s" % [team, denominator]
	return Color(config.get_value("palette", key, "ffffff"))
