extends Ability

var status: Node

var snowball_ii: bool

func apply(ability_relay, applicant_data):
	super(ability_relay, applicant_data)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("damage_boost"):
		applicant_data["damage_boost"] = applicants[ability_relay.source]["damage_boost"]
		ability_relay.crit_chance_modifiers.connect(crit_chance_modifiers)
	elif ability_relay.is_projectile > 0:
		call_deferred("freeze", ability_relay)
		applicant_data["damage_boost"] = true
		ability_relay.crit_chance_modifiers.connect(crit_chance_modifiers)

func freeze(ability_relay):
	status.apply(ability_relay, {"duration" = 0.5 * ability_relay.get_effect_duration()})

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.crit_chance_modifiers.is_connected(crit_chance_modifiers):
		ability_relay.crit_chance_modifiers.disconnect(crit_chance_modifiers)

func _ready() -> void:
	status = ability_handler.learn("freeze", 0)

func crit_chance_modifiers(_entity, crits) -> void:
	crits["base"] += 50
