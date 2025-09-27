extends Ability

var inheritance_level = 4

func _ready() -> void:
	var animated_clay = ability_handler.get_node_or_null("animated_clay")
	if animated_clay:
		animated_clay.multimold = true
