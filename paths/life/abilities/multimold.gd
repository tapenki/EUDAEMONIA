extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var animated_clay = ability_handler.get_node_or_null("animated_clay")
	if animated_clay:
		animated_clay.multimold = true
