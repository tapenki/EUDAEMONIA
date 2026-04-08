extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var dark_harvest = ability_handler.get_node_or_null("dark_harvest")
	if dark_harvest:
		dark_harvest.bad_crop = true
