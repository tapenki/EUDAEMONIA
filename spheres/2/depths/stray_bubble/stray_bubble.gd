extends Entity

func take_damage(damage):
	var damaged = super(damage)
	if damaged:
		kill.call_deferred(damage)
