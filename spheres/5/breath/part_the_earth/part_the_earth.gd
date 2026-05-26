extends Weapon

var thorn = preload("res://spheres/5/breath/anapnoi_thorn.tscn")
const wait_time = 1.2

func apply(ability_relay, applicant_data):
	if applicant_data.has("part_the_earth"):
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("part_the_earth"):
		applicant_data["part_the_earth"] = applicants[ability_relay.source]["part_the_earth"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 4:
		applicant_data["time"] = 0
		ability_relay.attack.connect(attack.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)
	if ability_relay.attack.is_connected(attack):
		ability_relay.attack.disconnect(attack)

func _process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("time") and applicants[ability_relay]["time"] > 0:
			applicants[ability_relay]["time"] -= delta * ability_relay.speed_scale * ability_relay.get_attack_rate()

func attack(direction, ability_relay):
	if not equipped:
		return
	if applicants[ability_relay]["time"] <= 0:
		fire(direction, ability_relay)
		applicants[ability_relay]["time"] = wait_time
		ability_relay.attack_success.emit(direction, self)

func fire(direction, ability_relay):
	for i in 5:
		var thorn_position = ability_relay.global_position + direction * 50 * (i + 1) + Vector2(randf_range(-10, 10), randf_range(-10, 10))
		var wall_intersections
		var ray_query = PhysicsRayQueryParameters2D.create(ability_relay.global_position, thorn_position)
		ray_query.collision_mask = 128
		wall_intersections = get_node("/root/Main").physics_space.intersect_ray(ray_query)
		if not wall_intersections:
			var thorn_instance = ability_relay.make_projectile(thorn, 
			thorn_position, 
			{"subscription" = 2, "weapon" = true, "part_the_earth" = true})
			get_node("/root/Main/Projectiles").add_child(thorn_instance)
			get_node("/root/Main/ParticleHandler").quick_particles("impact", 
			preload("res://generic/particles/bullet.png"),
			thorn_position,
			1,
			3,
			Config.get_team_color(ability_relay.owner.group, "secondary"))
	get_node("/root/Main").play_sound("HurtLight")

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += 10
