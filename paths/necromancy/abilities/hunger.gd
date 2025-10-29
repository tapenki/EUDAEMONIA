extends Ability

func _ready() -> void:
	if ability_handler.type == "entity" and not ability_handler.owner is Player:
		get_node("/root/Main").entity_death.connect(entity_death)

func entity_death(_dying_entity: Entity):
	ability_handler.apply_status(ability_handler, "haste", 0.5 * level)
	ability_handler.owner.heal(15*level)
