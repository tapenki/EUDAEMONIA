extends Ability

func apply(ability_relay, applicant_data):
	if not ability_relay.is_projectile > 1:
		return
	applicant_data["velocity_decay"] = false
	super(ability_relay, applicant_data)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		var attack_scale = ability_relay.get_effect_scale({"base" : 0.5 + 0.5 * level, "multiplier" : 1, "flat" : 0})
		var target = ability_relay.find_target(ability_relay.owner.global_position, 100 * attack_scale, ability_relay.owner.exclude)
		if target:
			var target_direction = ability_relay.owner.global_position.direction_to(target.global_position)
			ability_relay.owner.velocity += target_direction * 3600 * delta * ability_relay.speed_scale
			if not applicants[ability_relay]["velocity_decay"]:
				applicants[ability_relay]["velocity_decay"] = true
		if applicants[ability_relay]["velocity_decay"]:
			ability_relay.owner.velocity *= pow(0.1, delta * ability_relay.speed_scale)
