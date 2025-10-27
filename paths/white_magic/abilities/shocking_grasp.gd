extends Ability

func _ready() -> void:
	var mortal_shock = ability_handler.get_node_or_null("mortal_shock")
	if mortal_shock:
		mortal_shock.shocking_grasp = true
