extends Ability

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 3:
		return
	applicant_data["time"] = 0.0
	ability_relay.damage_taken_modifiers.connect(damage_taken_modifiers.bind(ability_relay))
	ability_relay.damage_taken.connect(damage_taken.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_taken_modifiers.is_connected(damage_taken_modifiers):
		ability_relay.damage_taken_modifiers.disconnect(damage_taken_modifiers)
	if ability_relay.damage_taken.is_connected(damage_taken):
		ability_relay.damage_taken.disconnect(damage_taken)

func _process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("time") and applicants[ability_relay]["time"] > 0:
			applicants[ability_relay]["time"] -= delta * ability_relay.speed_scale

func damage_taken_modifiers(damage, ability_relay) -> void:
	if applicants[ability_relay].has("time") and applicants[ability_relay]["time"] <= 0:
		damage["base"] -= 10 * level
		damage["blocked"] = true

func damage_taken(damage, ability_relay) -> void:
	if damage.has("blocked") and applicants[ability_relay].has("time"):
		applicants[ability_relay]["time"] = 4.0
