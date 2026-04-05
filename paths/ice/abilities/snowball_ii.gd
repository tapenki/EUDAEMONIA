extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var snowball = ability_handler.get_node_or_null("snowball")
	if snowball:
		snowball.snowball_ii = true
