extends Ability

var starvation: bool
var inherited_damage: float

func _ready() -> void:
	if ability_handler.type == "entity" and not ability_handler.owner is Player:
		get_node("/root/Main").entity_death.connect(entity_death)
	ability_handler.damage_dealt_modifiers.connect(damage_dealt_modifiers)

func entity_death(_dying_entity: Entity):
	ability_handler.apply_status(ability_handler, "haste", 0.5 * level)
	ability_handler.owner.heal(15*level)
	if starvation:
		inherited_damage += 0.04 * level

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["multiplier"] *= 1 + inherited_damage

func inherit(handler, tier):
	var ability_node = super(handler, tier)
	ability_node.inherited_damage += inherited_damage
