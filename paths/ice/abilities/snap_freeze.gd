extends Ability

func _ready() -> void:
	var frostbite = ability_relay.get_node_or_null("frostbite")
	if frostbite:
		frostbite.snap_freeze = true
