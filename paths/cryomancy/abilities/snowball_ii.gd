extends Ability

func _ready() -> void:
	var snowball = ability_handler.get_node_or_null("snowball")
	if snowball:
		ability_handler.crit_chance_modifiers.connect(snowball.crit_chance_modifiers)
		ability_handler.status_level_modifiers.connect(snowball.status_level_modifiers)
