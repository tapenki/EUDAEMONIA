extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var clockwinding = ability_handler.get_node_or_null("clockwinding")
	if clockwinding:
		clockwinding.overclock = true
