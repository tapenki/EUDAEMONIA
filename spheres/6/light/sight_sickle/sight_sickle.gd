extends Weapon

var bullet = preload("res://spheres/6/light/laser/laser.tscn")
const wait_time = 0.7

func apply(ability_relay, applicant_data):
	if applicant_data.has("sight_sickle"):
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("sight_sickle"):
		applicant_data["sight_sickle"] = applicants[ability_relay.source]["sight_sickle"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 4:
		applicant_data["time"] = 0
		applicant_data["cycle"] = 0
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
	var spin_direction = 1
	if applicants.has(ability_relay) and applicants[ability_relay].has("cycle"):
		applicants[ability_relay]["cycle"] = (applicants[ability_relay]["cycle"] + 1) % 2
		if applicants[ability_relay]["cycle"] == 0:
			spin_direction = -1
	var laser_instance = ability_relay.make_projectile(bullet, 
	ability_relay.global_position, 
	{"subscription" = 2, "weapon" = true, "sight_sickle" = true},
	direction.rotated(-3 * spin_direction) * 600)
	laser_instance.max_length = 200
	laser_instance.spin = 4 * spin_direction
	get_node("/root/Main/Projectiles").add_child(laser_instance)
	get_node("/root/Main").play_sound("Explosion")

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += 10
