extends Ability

var inherited_damage: float

func _ready() -> void:
	ability_handler.damage_dealt_modifiers.connect(damage_dealt_modifiers)

func get_modifier():
	if ability_handler.is_entity:
		var health_values = ability_handler.get_health(ability_handler.owner.health, ability_handler.owner.max_health)
		return health_values["max_health"] * 0.02 * level
	return inherited_damage

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["source"] += get_modifier()

func inherit(handler, tier):
	var ability_node = super(handler, tier)
	ability_node.inherited_damage += get_modifier()
