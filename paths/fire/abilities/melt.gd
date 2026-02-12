extends Ability

func _ready() -> void:
	ability_handler.damage_dealt_modifiers.connect(damage_dealt_modifiers)

func damage_dealt_modifiers(entity, modifiers) -> void:
	if not entity:
		return
	var burn = entity.ability_handler.get_node_or_null("burn")
	if burn:
		modifiers["base"] += burn.level * 0.25 * level
