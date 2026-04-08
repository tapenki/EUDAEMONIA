extends Ability

var status: Node

func _ready() -> void:
	status = ability_handler.learn("doom", 0)

func apply(ability_relay, applicant_data):
	super(ability_relay, applicant_data)
	ability_relay.damage_dealt.connect(damage_dealt.bind(ability_relay))

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt.is_connected(damage_dealt):
		ability_relay.damage_dealt.disconnect(damage_dealt)

func damage_dealt(entity, damage, ability_relay) -> void:
	if damage.has("first_blood"):
		status.apply(entity.ability_relay, {"stacks" = 4 * level})
		status.damage_taken(damage, entity.ability_relay)
