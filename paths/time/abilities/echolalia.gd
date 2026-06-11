extends Ability

var summon = preload("res://paths/time/duplicate/duplicate.tscn")

func apply(ability_relay, applicant_data):
	if applicant_data.has("echo_step"):
		ability_relay.max_health_modifiers.connect(max_health_modifiers)
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("echo_step"):
		applicant_data["echo_step"] = applicants[ability_relay.source]["echo_step"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 3:
		applicant_data["charge"] = 0
		applicant_data["pain_walk"] = 0
		ability_relay.movement.connect(movement.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.movement.is_connected(movement):
		ability_relay.movement.disconnect(movement)
	if ability_relay.max_health_modifiers.is_connected(max_health_modifiers):
		ability_relay.max_health_modifiers.disconnect(max_health_modifiers)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func spawn(spawn_position, ability_relay):
	var summon_instance = ability_relay.make_summon(summon, 
	spawn_position,
	{"subscription" = 2, "echo_step" = true})  ## inheritance
	get_node("/root/Main/Entities").add_child(summon_instance)
	get_node("/root/Main").entity_manifestation.emit(summon_instance)
	#get_node("/root/Main").spawn_entity(summon_instance, 0.5)

func movement(distance, ability_relay) -> void:
	if not applicants[ability_relay].has("charge"):
		return
	applicants[ability_relay]["charge"] += distance
	if applicants[ability_relay]["charge"] >= 250:
		applicants[ability_relay]["charge"] -= 250
		spawn(ability_relay.owner.global_position, ability_relay)

func max_health_modifiers(modifiers) -> void:
	modifiers["base"] += 20 * level

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += 3 * level
