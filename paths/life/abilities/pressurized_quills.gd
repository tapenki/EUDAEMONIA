extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var quill_spray = ability_handler.get_node_or_null("quill_spray")
	if quill_spray:
		quill_spray.pressurized_quills = true
