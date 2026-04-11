extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var from_ashes = ability_handler.get_node_or_null("from_ashes")
	if from_ashes:
		from_ashes.fiery_rebirth = true
