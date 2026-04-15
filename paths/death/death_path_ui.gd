extends Control

#@export var path: String

func unlearn():
	var ability_handler = get_node("/root/Main/PlayerAbilityHandler")
	var ui = get_node("/root/Main/UI")
	for mastery in get_node("Masteries").get_children():
		var mastery_node = ability_handler.get_node_or_null(mastery.subject)
		if mastery_node:
			ability_handler.unlearn("dark_price", 40)
			ability_handler.unlearn(mastery.subject, mastery_node.level)
	for ability in get_node("Abilities").get_children():
		var ability_node = ability_handler.get_node_or_null(ability.subject)
		if ability_node:
			ui.upgrade_points += roundi(ability_node.level)
			ability_handler.unlearn(ability.subject, ability_node.level)
	ui.unlock_points += 1
	queue_free()
