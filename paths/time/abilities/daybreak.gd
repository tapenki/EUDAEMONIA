extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var hour_hand = ability_handler.get_node_or_null("hour_hand")
	if hour_hand:
		hour_hand.daybreak = true
