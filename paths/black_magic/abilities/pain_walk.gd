extends Ability

var inheritance_level = 3

func _ready() -> void:
	var trail_of_thorns = ability_handler.get_node_or_null("trail_of_thorns")
	if trail_of_thorns:
		trail_of_thorns.pain_walk = true
