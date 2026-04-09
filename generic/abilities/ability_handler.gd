extends Node

var subscribers: Dictionary

signal ability_added()

func _ready() -> void:
	subscribe(get_node("/root/Main/Entities/Player/AbilityRelay"), {"subscription" = 5})

func subscribe(ability_relay, subscription_data):
	ability_relay.ability_handler = self
	ability_relay.freed.connect(unsubscribe.bind(ability_relay))
	subscribers[ability_relay] = subscription_data.duplicate()
	for ability_node in get_children():
		ability_node.apply(ability_relay, subscription_data)

func unsubscribe(ability_relay):
	subscribers.erase(ability_relay)
	#for ability_node in ability_relay.applied_abilities:
	#	ability_node.disapply(ability_relay)
	ability_relay.ability_handler = null

func learn(ability, levels = 1):
	var ability_node = get_node_or_null(NodePath(ability))
	if ability_node:
		ability_node.level += levels
	else:
		ability_node = Node.new()
		ability_node.set_script(AbilityData.ability_data[ability]["script"])
		ability_node.level = levels
		ability_node.name = ability
		add_child(ability_node)
		for i in subscribers.keys():
			ability_node.apply(i, subscribers[i])
		ability_added.emit(ability)
	get_node("/root/Main/UI").update_abilities.emit()
	return ability_node
