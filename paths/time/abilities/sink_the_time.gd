extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var event_horizon = ability_handler.get_node_or_null("event_horizon")
	if event_horizon:
		event_horizon.sink_the_time = true
