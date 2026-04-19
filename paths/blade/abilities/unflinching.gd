extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var hold_ground = ability_handler.get_node_or_null("hold_ground")
	if hold_ground:
		hold_ground.unflinching = true
