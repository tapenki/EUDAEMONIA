extends Ability

func _ready() -> void:
	var shatter = ability_handler.get_node_or_null("shatter")
	if shatter:
		shatter.shard_blast = true

func inherit(_handler, _tier):
	return
