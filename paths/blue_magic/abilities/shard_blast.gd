extends Ability

var inheritance_level = 4

func _ready() -> void:
	var shatter = ability_handler.get_node_or_null("shatter")
	if shatter:
		shatter.shard_blast = true
