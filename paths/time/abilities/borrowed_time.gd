extends Ability

var status: Node

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 3:
		return
	ability_relay.damage_taken_modifiers.connect(damage_taken_modifiers)
	ability_relay.damage_taken.connect(damage_taken.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_taken_modifiers.is_connected(damage_taken_modifiers):
		ability_relay.damage_taken_modifiers.disconnect(damage_taken_modifiers)
	if ability_relay.damage_taken.is_connected(damage_taken):
		ability_relay.damage_taken.disconnect(damage_taken)

func _ready() -> void:
	status = ability_handler.learn("burn", 0)

func damage_taken_modifiers(damage) -> void:
	damage["flat"] -= 10 * level
	damage["borrowed_time"] = true

func damage_taken(damage, ability_relay) -> void:
	if damage.has("borrowed_time"):
		status.apply(ability_relay, {"stacks" = 2 * level, "duration" = ability_relay.get_effect_duration()})
