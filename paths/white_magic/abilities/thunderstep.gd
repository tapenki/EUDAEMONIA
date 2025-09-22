extends Ability

var inheritance_level = 3
var type = "Upgrade"

var charge = 0

func _ready() -> void:
	ability_handler.movement.connect(movement)
	ability_handler.move_speed_modifiers.connect(move_speed_modifiers)

func movement(distance) -> void:
	charge += distance
	if charge >= 225:
		charge -= 225
		ability_handler.attack_impact.emit(ability_handler.owner.global_position, null)

func move_speed_modifiers(modifiers) -> void:
	modifiers["source"] += level * 50
