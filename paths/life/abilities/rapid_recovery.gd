extends Ability

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 3:
		return
	super(ability_relay, applicant_data)
	applicant_data["time"] = 0.0
	ability_relay.damage_taken.connect(damage_taken.bind(ability_relay))

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_taken.is_connected(damage_taken):
		ability_relay.damage_taken.disconnect(damage_taken)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants.has(ability_relay) and applicants[ability_relay].has("time") and applicants[ability_relay]["time"] > 0:
			applicants[ability_relay]["time"] -= delta*ability_relay.speed_scale
			ability_relay.owner.heal(1.5*level*delta*ability_relay.speed_scale)

func damage_taken(_damage, ability_relay) -> void:
	if applicants.has(ability_relay) and applicants[ability_relay].has("time"):
		applicants[ability_relay]["time"] = 4.0 * ability_relay.get_effect_duration()
