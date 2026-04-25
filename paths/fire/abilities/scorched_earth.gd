extends Ability

var bullet = preload("res://paths/fire/scorched_earth/scorched_earth.tscn")

func apply(ability_relay, applicant_data):
	if applicant_data.has("scorched_earth"):
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
		ability_relay.attack_scale_modifiers.connect(attack_scale_modifiers)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("scorched_earth"):
		applicant_data["scorched_earth"] = applicants[ability_relay.source]["scorched_earth"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
		ability_relay.attack_scale_modifiers.connect(attack_scale_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)
	if ability_relay.attack_scale_modifiers.is_connected(attack_scale_modifiers):
		ability_relay.attack_scale_modifiers.disconnect(attack_scale_modifiers)

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)

func entity_death(dying_entity: Entity):
	for ability_relay in applicants:
		if applicants[ability_relay].has("subscription") and applicants[ability_relay]["subscription"] < 5:
			return
		var bullet_instance = ability_relay.make_projectile(bullet, 
		dying_entity.global_position, 
		{"subscription" = 1, "scorched_earth" = true},
		Vector2())
		get_node("/root/Main/Projectiles").add_child(bullet_instance)

func damage_dealt_modifiers(_entity, damage) -> void:
	damage["base"] += 5 * level

func attack_scale_modifiers(modifiers) -> void:
	modifiers["base"] += 0.4 * level - 0.4
