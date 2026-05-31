extends Ability

func apply(ability_relay, applicant_data):
	if not applicant_data.has("subscription") or applicant_data["subscription"] >= 3:
		ability_relay.damage_taken.connect(damage_taken.bind(ability_relay))
		ability_relay.speed_scale_modifiers.connect(speed_scale_modifiers.bind(ability_relay))
		applicant_data["time"] = 0.0
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_taken.is_connected(damage_taken):
		ability_relay.damage_taken.disconnect(damage_taken)
	if ability_relay.speed_scale_modifiers.is_connected(speed_scale_modifiers):
		ability_relay.speed_scale_modifiers.disconnect(speed_scale_modifiers)

func _ready() -> void:
	get_node("/root/Main").intermission.connect(intermission)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("time"):
			applicants[ability_relay]["time"] -= delta

func intermission(_day):
	for ability_relay in applicants:
		if applicants[ability_relay].has("time"):
			applicants[ability_relay]["time"] = 0.0

func damage_taken(_damage, ability_relay) -> void:
	if applicants.has(ability_relay) and applicants[ability_relay].has("time"):
		applicants[ability_relay]["time"] = level * ability_relay.get_effect_duration()

func speed_scale_modifiers(modifiers, ability_relay) -> void:
	if applicants.has(ability_relay) and applicants[ability_relay].has("time") and applicants[ability_relay]["time"] > 0:
		modifiers["base"] += 0.5
