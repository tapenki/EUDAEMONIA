extends Ability

func _ready() -> void:
	if ability_relay.is_projectile:
		if ability_relay.owner.hits_left > 0:
			ability_relay.owner.hits_left += level
