extends Ability

var explosion = preload("res://paths/blade/hold_ground_explosion/hold_ground_explosion.tscn")

var imposition: bool

func apply(ability_relay, applicant_data):
	if applicant_data.has("hold_ground"):
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
		ability_relay.effect_scale_modifiers.connect(effect_scale_modifiers.bind(ability_relay))
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("hold_ground"):
		applicant_data["hold_ground"] = applicants[ability_relay.source]["hold_ground"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers.bind(ability_relay))
		ability_relay.effect_scale_modifiers.connect(effect_scale_modifiers.bind(ability_relay))
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 3:
		applicant_data["imposition"] = 0.0
		applicant_data["charge"] = 0.0
		ability_relay.movement.connect(movement.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)
	if ability_relay.effect_scale_modifiers.is_connected(effect_scale_modifiers):
		ability_relay.effect_scale_modifiers.disconnect(effect_scale_modifiers)
	if ability_relay.movement.is_connected(movement):
		ability_relay.movement.disconnect(movement)

func _ready() -> void:
	get_node("/root/Main").intermission.connect(intermission)

func intermission(_day: int) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("charge"):
			applicants[ability_relay]["charge"] = 0.0
		if applicants[ability_relay].has("imposition"):
			applicants[ability_relay]["imposition"] = 0.0

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("charge") and ability_relay.is_entity > 0:
			if ability_relay.owner.velocity.length() < 25:
				applicants[ability_relay]["charge"] += delta * ability_relay.speed_scale
				if applicants[ability_relay]["charge"] >= 0.25:
					applicants[ability_relay]["charge"] -= 0.25
					var amplifier = 1.0
					if imposition and applicants[ability_relay]["imposition"] > 250:
						amplifier += floor(applicants[ability_relay]["imposition"] / 250) * 0.25
					applicants[ability_relay]["imposition"] = max(0, applicants[ability_relay]["imposition"] - 250)
					var explosion_instance = ability_relay.make_projectile(explosion, 
					ability_relay.global_position, 
					{"subscription" = 2, "hold_ground" = amplifier},
					Vector2())
					explosion_instance.scale_multiplier = 3
					get_node("/root/Main/Projectiles").add_child(explosion_instance)
					
			else:
				applicants[ability_relay]["charge"] = 0.0

func movement(distance, ability_relay) -> void:
	if not imposition or not applicants[ability_relay].has("imposition"):
		return
	applicants[ability_relay]["imposition"] = min(1000.0, applicants[ability_relay]["imposition"] + distance)

func damage_dealt_modifiers(_entity, damage, ability_relay) -> void:
	damage["base"] += 5 * level
	if applicants[ability_relay].has("hold_ground"):
		damage["multiplier"] *= applicants[ability_relay]["hold_ground"]

func effect_scale_modifiers(modifiers, ability_relay) -> void:
	if applicants[ability_relay].has("hold_ground"):
		modifiers["base"] *= applicants[ability_relay]["hold_ground"]
