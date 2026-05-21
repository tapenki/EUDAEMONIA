extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var time_stop = ability_handler.get_node_or_null("time_stop")
	if time_stop:
		time_stop.no_future = true
