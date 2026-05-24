extends Ability

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 3:
		return
	applicant_data["time"] = 0.0
	ability_relay.damage_taken_modifiers.connect(damage_taken_modifiers.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_taken_modifiers.is_connected(damage_taken_modifiers):
		ability_relay.damage_taken_modifiers.disconnect(damage_taken_modifiers)

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)

func day_start(_day: int) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("time"):
			applicants[ability_relay]["time"] = 5.0 * ability_relay.get_effect_duration()

func _process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("time") and applicants[ability_relay]["time"] > 0:
			applicants[ability_relay]["time"] -= delta * ability_relay.speed_scale

func damage_taken_modifiers(damage, ability_relay) -> void:
	if applicants.has(ability_relay) and applicants[ability_relay]["time"] > 0:
		damage["flat"] -= 10 * level
