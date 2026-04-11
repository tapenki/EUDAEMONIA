extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var conflagration = ability_handler.get_node_or_null("conflagration")
	if conflagration:
		conflagration.inferno = true
