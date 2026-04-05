extends Ability

func apply(ability_relay, _applicant_data):
	if not ability_relay.is_projectile:
		return
	if ability_relay.owner.hits_left > 0:
			ability_relay.owner.hits_left += level
