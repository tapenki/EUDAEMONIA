extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var burn = ability_handler.learn("burn", 0)
	if burn:
		burn.pyre = true
