#extends Ability
#
#var inherited_damage: float
#
#func _ready() -> void:
	#ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
#
#func get_modifier():
	#if ability_relay.is_entity:
		#var health_values = ability_relay.get_health(ability_relay.owner.health, ability_relay.owner.max_health)
		#return health_values["max_health"] * 0.02 * level
	#return inherited_damage
#
#func damage_dealt_modifiers(_entity, modifiers) -> void:
	#modifiers["base"] += get_modifier()
#
#func inherit(handler, tier):
	#var ability_node = super(handler, tier)
	#ability_node.inherited_damage += get_modifier()
