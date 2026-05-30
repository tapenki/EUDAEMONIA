extends Ability

var projectile_scene = preload("res://paths/fire/ring_of_fire/ring_of_fire.tscn")

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 3:
		var projectile_instance = ability_relay.make_projectile(projectile_scene, 
		Vector2(),
		{"subscription" = 2, "ring_of_fire" = true},
		Vector2())
		ability_relay.add_child(projectile_instance)
		applicant_data["ring_of_fire_instance"] = projectile_instance
	if applicant_data.has("ring_of_fire"):
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("ring_of_fire"):
		applicant_data["ring_of_fire"] = applicants[ability_relay.source]["ring_of_fire"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	if applicants.has(ability_relay) and applicants[ability_relay].has("ring_of_fire_instance"):
		applicants[ability_relay]["ring_of_fire_instance"].kill()
	super(ability_relay)

func damage_dealt_modifiers(_entity, damage) -> void:
	var scorched_earth_level = 1
	var scorched_earth = ability_handler.get_node_or_null("scorched_earth")
	if scorched_earth:
		scorched_earth_level = scorched_earth.level
	damage["base"] += 3 * scorched_earth_level
