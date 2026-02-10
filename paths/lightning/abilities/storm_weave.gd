extends Ability

func _ready() -> void:
	var chain_bolt = ability_handler.get_node_or_null("chain_bolt")
	if chain_bolt:
		chain_bolt.storm_weave = true

func inherit(_handler, _tier):
	return
