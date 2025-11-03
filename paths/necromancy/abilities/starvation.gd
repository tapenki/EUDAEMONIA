extends Ability

func _ready() -> void:
	var hunger = ability_handler.get_node_or_null("hunger")
	if hunger:
		hunger.starvation = true
