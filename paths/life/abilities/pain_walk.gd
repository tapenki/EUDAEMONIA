extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var trail_of_thorns = ability_handler.get_node_or_null("trail_of_thorns")
	if trail_of_thorns:
		trail_of_thorns.pain_walk = true
