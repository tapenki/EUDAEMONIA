extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var firespawning = ability_handler.get_node_or_null("firespawning")
	if firespawning:
		firespawning.undying_flames = true
