extends Ability

var status: Node

func _ready() -> void:
	status = ability_handler.learn("burn", 0)

func apply(ability_relay, applicant_data):
	super(ability_relay, applicant_data)
	ability_relay.crit_chance_modifiers.connect(crit_chance_modifiers)
	ability_relay.damage_dealt.connect(damage_dealt.bind(ability_relay))

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.crit_chance_modifiers.is_connected(crit_chance_modifiers):
		ability_relay.crit_chance_modifiers.disconnect(crit_chance_modifiers)
	if ability_relay.damage_dealt.is_connected(damage_dealt):
		ability_relay.damage_dealt.disconnect(damage_dealt)

func crit_chance_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += 3 * level

func damage_dealt(entity, damage, ability_relay) -> void:
	if damage.get("crits", 0) > 0:
		status.apply(entity.ability_relay, {"stacks" = 3 * level, "duration" = ability_relay.get_effect_duration()})
