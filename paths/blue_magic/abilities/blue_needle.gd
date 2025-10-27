extends Ability

func _ready() -> void:
	if ability_handler.type == "projectile":
		if ability_handler.owner.hits_left > 0:
			ability_handler.owner.hits_left += level
