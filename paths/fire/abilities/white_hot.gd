extends Ability

func _ready() -> void:
	ability_relay.crit_chance_modifiers.connect(crit_chance_modifiers)

func crit_chance_modifiers(entity, modifiers) -> void:
	if not entity:
		return
	var burn = entity.ability_relay.get_node_or_null("burn")
	if burn and burn.level >= 50:
		modifiers["base"] += 100
