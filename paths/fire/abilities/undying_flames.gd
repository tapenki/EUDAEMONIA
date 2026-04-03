extends Ability

func _ready() -> void:
	var firespawning = ability_relay.get_node_or_null("firespawning")
	if firespawning:
		firespawning.undying_flames = true

func inherit(_handler, _tier):
	return
