extends Ability

var bullet = preload("res://paths/ice/shard.tscn")

func apply(ability_relay, applicant_data):
	if ability_relay.owner.scene_file_path == "res://paths/ice/shard.tscn":
		applicant_data["shatter_power"] = true
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("shatter_power"):
		applicant_data["shatter_power"] = applicants[ability_relay.source]["shatter_power"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)

func entity_death(dying_entity: Entity):
	for applicant in applicants:
		if applicants[applicant].has("subscription") and applicants[applicant]["subscription"] < 5:
			return
		var total = 3
		if dying_entity.summoned:
			total = 1
		var angle = randf_range(0, TAU)
		var target = applicant.find_target(dying_entity.global_position, 9999, {dying_entity : true})
		if target:
			angle = dying_entity.global_position.direction_to(target.global_position).angle()
		for repeat in total:
			var bullet_instance = applicant.make_projectile(bullet, 
			dying_entity.global_position, 
			{"subscription" = 2},
			Vector2.from_angle(angle + (TAU / total * repeat)) * 600)
			bullet_instance.exclude[dying_entity] = INF
			get_node("/root/Main/Projectiles").add_child(bullet_instance)

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += 5 * level
