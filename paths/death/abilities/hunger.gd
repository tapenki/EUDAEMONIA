extends Ability

var starvation: bool
var inherited_damage: float

func _ready() -> void:
	if ability_relay.is_entity and not ability_relay.owner is Player:
		get_node("/root/Main").entity_death.connect(entity_death)
	ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)

func entity_death(_dying_entity: Entity):
	ability_relay.apply_status(ability_relay, "haste", 0.5 * level)
	ability_relay.owner.heal(15*level)
	if starvation:
		inherited_damage += 0.04 * level

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["multiplier"] *= 1 + inherited_damage

func inherit(handler, tier):
	var ability_node = super(handler, tier)
	ability_node.inherited_damage += inherited_damage
