extends Ability

var status: Node

func get_mortal_shock_level():
	var mortal_shock = ability_handler.get_node_or_null("mortal_shock")
	if mortal_shock:
		return mortal_shock.level
	return 1

func _ready() -> void:
	status = ability_handler.learn("shock", 0)

func apply(ability_relay, applicant_data):
	super(ability_relay, applicant_data)
	ability_relay.damage_dealt.connect(damage_dealt)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt.is_connected(damage_dealt):
		ability_relay.damage_dealt.disconnect(damage_dealt)

func damage_dealt(entity, damage) -> void:
	if damage.has("first_blood"):
		status.apply(entity.ability_relay, {"stacks" = 10 * get_mortal_shock_level()})
