extends Ability

var inheritance_level = 1

func _ready() -> void:
	ability_handler.status_applied.connect(status_applied)
	
func status_applied(status, _levels) -> void:
	if status.name == "burn":
		status.damage_multiplier += 0.1 * level
