extends Ability

func _ready() -> void:
	var snowball = ability_relay.get_node_or_null("snowball")
	if snowball:
		ability_relay.crit_chance_modifiers.connect(snowball.crit_chance_modifiers)
		ability_relay.status_level_modifiers.connect(snowball.status_level_modifiers)
