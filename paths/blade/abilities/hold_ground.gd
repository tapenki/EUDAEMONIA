extends Ability

var explosion = preload("res://paths/blade/hold_ground_explosion/hold_ground_explosion.tscn")

var unflinching: bool

func apply(ability_relay, applicant_data):
	if applicant_data.has("hold_ground"):
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
		ability_relay.attack_scale_modifiers.connect(attack_scale_modifiers)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("hold_ground"):
		applicant_data["hold_ground"] = applicants[ability_relay.source]["hold_ground"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
		ability_relay.attack_scale_modifiers.connect(attack_scale_modifiers)
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 3:
		applicant_data["shockwave_count"] = 0
		applicant_data["charge"] = 0
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)
	if ability_relay.attack_scale_modifiers.is_connected(attack_scale_modifiers):
		ability_relay.attack_scale_modifiers.disconnect(attack_scale_modifiers)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("charge") and ability_relay.is_entity:
			if ability_relay.owner.velocity.length() < 25:
				applicants[ability_relay]["charge"] += delta * ability_relay.speed_scale
				if applicants[ability_relay]["charge"] >= 0.25:
					applicants[ability_relay]["charge"] -= 0.25
					var explosion_instance = ability_relay.make_projectile(explosion, 
					ability_relay.global_position, 
					{"subscription" = 2, "hold_ground" = 1.0 + 0.25 * applicants[ability_relay]["shockwave_count"]},
					Vector2())
					explosion_instance.scale_multiplier = 2
					get_node("/root/Main/Projectiles").add_child(explosion_instance)
					if unflinching and applicants[ability_relay]["shockwave_count"] < 4:
						applicants[ability_relay]["shockwave_count"] += 1
			else:
				applicants[ability_relay]["shockwave_count"] = 0
				applicants[ability_relay]["charge"] = 0

func damage_dealt_modifiers(_entity, damage, ability_relay) -> void:
	damage["base"] += 5 * level - 5
	if applicants[ability_relay].has("hold_ground"):
		damage["multiplier"] *= applicants[ability_relay]["hold_ground"]

func attack_scale_modifiers(modifiers) -> void:
	modifiers["base"] += 0.4 * level - 0.4
