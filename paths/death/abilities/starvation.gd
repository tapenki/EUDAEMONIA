extends Ability

func _ready() -> void:
	var hunger = ability_relay.get_node_or_null("hunger")
	if hunger:
		hunger.starvation = true
