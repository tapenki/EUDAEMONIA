extends Ability

var inheritance_level = 4

func _ready() -> void:
	var firespawning = ability_handler.get_node_or_null("firespawning")
	if firespawning:
		firespawning.undying_flames = true
