extends Ability

func _ready() -> void:
	var ball_lightning = ability_handler.get_node_or_null("ball_lightning")
	if ball_lightning:
		ball_lightning.close_orbit = true

func inherit(_handler, _tier):
	return
