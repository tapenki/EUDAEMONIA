extends Weapon

var bullet = preload("res://paths/blade/sword/slash.tscn")
const wait_time = 0.5

func apply(ability_relay, applicant_data):
	if applicant_data.has("sword"):
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("sword"):
		applicant_data["sword"] = applicants[ability_relay.source]["sword"]
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
			applicants[ability_relay]["time"] -= delta * ability_relay.speed_scale

func attack(direction, ability_relay):
	if not equipped:
		return
	if applicants[ability_relay]["time"] <= 0:
		fire(direction, ability_relay)
		applicants[ability_relay]["time"] = wait_time
		ability_relay.attack_success.emit(direction, self)

func fire(direction, ability_relay):
	var bullet_instance = ability_relay.make_projectile(bullet, 
	ability_relay.global_position + direction * 25, 
	{"subscription" = 2, "sword" = true},
	direction * 1200)
	get_node("/root/Main/Projectiles").add_child(bullet_instance)
	get_node("/root/Main").play_sound("Explosion")

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += 5
