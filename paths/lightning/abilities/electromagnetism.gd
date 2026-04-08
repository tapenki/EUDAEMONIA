extends Ability

func apply(ability_relay, applicant_data):
	if not ability_relay.is_projectile:
		return
	applicant_data["velocity_decay"] = false
	super(ability_relay, applicant_data)

func _physics_process(_delta: float) -> void:
	for ability_relay in applicants:
		var attack_scale = ability_relay.get_attack_scale({"base" : 0, "multiplier" : 0.5 + 0.5 * level, "flat" : 0})
		var target = ability_relay.find_target(ability_relay.owner.global_position, 100 * attack_scale, ability_relay.owner.exclude)
		if target:
			var target_direction = ability_relay.owner.global_position.direction_to(target.global_position)
			ability_relay.owner.velocity += target_direction * 60
			if not applicants[ability_relay]["velocity_decay"]:
				applicants[ability_relay]["velocity_decay"] = true
		if applicants[ability_relay]["velocity_decay"]:
			ability_relay.owner.velocity = ability_relay.owner.velocity.limit_length(pow(ability_relay.owner.velocity.length(), 0.99))
