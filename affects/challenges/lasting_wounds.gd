extends Ability

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 4:
		return
	super(ability_relay, applicant_data)
	ability_relay.damage_taken.connect(damage_taken.bind(ability_relay))

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_taken.is_connected(damage_taken):
		ability_relay.damage_taken.disconnect(damage_taken)

func damage_taken(damage, ability_relay) -> void:
	if not damage.has("group") or damage["group"] != ability_relay.owner.group:
		ability_relay.owner.health = min(ability_relay.owner.health+5, ability_relay.owner.max_health)
		ability_relay.ability_handler.learn("dark_price", 5)
