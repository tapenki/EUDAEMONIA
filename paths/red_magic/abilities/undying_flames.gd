extends Ability

func _ready() -> void:
	var firespawning = ability_handler.get_node_or_null("firespawning")
	if firespawning:
		firespawning.undying_flames = true

func inherit(_handler, _tier):
	return
