extends Ability

var projectile_scene = preload("res://paths/fire/ring_of_fire/ring_of_fire.tscn")

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 3:
		var projectile_instance = ability_relay.make_projectile(projectile_scene, 
		Vector2(),
		{"subscription" = 2, "scorched_earth" = true},
		Vector2())
		ability_relay.add_child(projectile_instance)
		applicant_data["ring_of_fire"] = projectile_instance
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	if applicants.has(ability_relay) and applicants[ability_relay].has("ring_of_fire"):
		applicants[ability_relay]["ring_of_fire"].kill()
	super(ability_relay)
