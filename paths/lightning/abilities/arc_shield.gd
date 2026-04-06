extends Ability

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 3:
		return
	super(ability_relay, applicant_data)
	ability_relay.damage_taken_modifiers.connect(damage_taken_modifiers.bind(ability_relay))

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_taken_modifiers.is_connected(damage_taken_modifiers):
		ability_relay.damage_taken_modifiers.disconnect(damage_taken_modifiers)

func damage_taken_modifiers(damage, ability_relay) -> void:
	var odds = {"base": 20, "multiplier": 1.0}
	odds["crits"] = damage["crits"]
	if ability_relay.roll_chance(odds):
		damage["multiplier"] *= 0
