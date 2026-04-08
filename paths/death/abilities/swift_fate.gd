extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var doom = ability_handler.learn("doom", 0)
	doom.swift_fate = true
