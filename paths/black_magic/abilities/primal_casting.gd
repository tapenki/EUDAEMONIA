extends Ability

var inherited: float

func _ready() -> void:
	ability_handler.damage_dealt_modifiers.connect(damage_dealt_modifiers)

func get_modifier():
	if ability_handler.type == "entity":
		var health_values = ability_handler.get_health(ability_handler.owner.health, ability_handler.owner.max_health)
		return health_values["max_health"] * 0.04 * level
	return inherited

func damage_dealt_modifiers(_entity, modifiers, _crits) -> void:
	modifiers["source"] += get_modifier()

func inherit(handler, tier):
	var ability_node = super(handler, tier)
	ability_node.inherited += get_modifier()
