class_name Ability extends Node

@onready var ability_handler = $"../"

@export var level: float

var applicants: Dictionary

func apply(ability_relay, applicant_data):
	ability_relay.freed.connect(disapply.bind(ability_relay))
	ability_relay.applied_abilities[self] = true
	applicants[ability_relay] = applicant_data

func disapply(ability_relay):
	ability_relay.applied_abilities.erase(self)
	applicants.erase(ability_relay)
	if ability_relay.freed.is_connected(disapply):
		ability_relay.freed.disconnect(disapply)

func serialize():
	return {"level" : level}

func deserialize(data):
	level = data["level"]
