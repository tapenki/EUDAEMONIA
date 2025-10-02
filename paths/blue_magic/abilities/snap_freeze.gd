extends Ability

var inheritance_level = 1

func _ready() -> void:
	var frostbite = ability_handler.get_node_or_null("frostbite")
	if frostbite:
		frostbite.snap_freeze = true
