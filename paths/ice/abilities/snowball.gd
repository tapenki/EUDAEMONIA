extends Ability

var status: Node

var snowball_ii: bool

func apply(ability_relay, applicant_data):
	super(ability_relay, applicant_data)
	if ability_relay.is_projectile > 0:
		if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("damage_boost"):
			applicant_data["damage_boost"] = applicants[ability_relay.source]["damage_boost"]
			applicant_data["scale_boost"] = applicants[ability_relay.source]["scale_boost"]
		else:
			applicant_data["damage_boost"] = 0.0
			applicant_data["scale_boost"] = 0.0
		ability_relay.effect_scale_modifiers.connect(effect_scale_modifiers.bind(ability_relay))
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
	ability_relay.attack_success.connect(attack_success.bind(ability_relay))
	#ability_relay.crit_chance_modifiers.connect(crit_chance_modifiers.bind(ability_relay))

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.effect_scale_modifiers.is_connected(effect_scale_modifiers):
		ability_relay.effect_scale_modifiers.disconnect(effect_scale_modifiers)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)
	if ability_relay.attack_success.is_connected(attack_success):
		ability_relay.attack_success.disconnect(attack_success)
	#if ability_relay.crit_chance_modifiers.is_connected(crit_chance_modifiers):
		#ability_relay.crit_chance_modifiers.disconnect(crit_chance_modifiers)

func _ready() -> void:
	status = ability_handler.learn("freeze", 0)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants.has(ability_relay) and applicants[ability_relay].has("damage_boost"):
			applicants[ability_relay]["damage_boost"] += 3 * delta * level * ability_relay.speed_scale
			applicants[ability_relay]["scale_boost"] += 0.5 * delta * ability_relay.speed_scale

func effect_scale_modifiers(modifiers, ability_relay) -> void:
	if applicants.has(ability_relay):
		var mult = 1
		if snowball_ii and applicants[ability_relay].has("weapon"):
			mult = 3
		modifiers["base"] += applicants[ability_relay]["scale_boost"] * mult

func damage_dealt_modifiers(_entity, modifiers, ability_relay) -> void:
	if applicants.has(ability_relay):
		var mult = 1
		if snowball_ii and applicants[ability_relay].has("weapon"):
			mult = 3
		modifiers["base"] += applicants[ability_relay]["damage_boost"] * mult

func attack_success(_direction, _weapon, ability_relay) -> void:
	if not snowball_ii:
		return
	get_node("/root/Main/ParticleHandler").quick_particles("impact", 
	preload("res://paths/statuses/chill/snow.png"),
	ability_relay.global_position,
	2,
	3,
	Config.get_team_color(ability_relay.owner.group, "secondary"))
	status.apply(ability_relay, {"duration" = 0.2})

#func crit_chance_modifiers(_entity, modifiers, ability_relay) -> void:
	#if not snowball_ii:
		#return
	#modifiers["base"] += applicants[ability_relay]["damage_boost"]
