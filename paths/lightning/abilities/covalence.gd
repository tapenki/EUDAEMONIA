extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var ball_lightning = ability_handler.get_node_or_null("ball_lightning")
	if ball_lightning:
		ball_lightning.apply_covalence()
