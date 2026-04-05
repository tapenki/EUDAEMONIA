extends Ability

var bullet = preload("res://generic/projectiles/bullet.tscn")
const wait_time = 0.35

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 4:
		return
	applicant_data["time"] = 0
	super(ability_relay, applicant_data)
	ability_relay.attack.connect(attack.bind(ability_relay))

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.attack.is_connected(attack):
		ability_relay.attack.disconnect(attack)

func _process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay]["time"] > 0:
			applicants[ability_relay]["time"] -= delta * ability_relay.speed_scale

func attack(direction, ability_relay):
	if applicants[ability_relay]["time"] <= 0:
		fire(direction, ability_relay)
		applicants[ability_relay]["time"] = wait_time

func fire(direction, ability_relay):
	var bullet_instance = ability_relay.make_projectile(bullet, 
	ability_relay.global_position + direction * 25, 
	2,
	direction * 600)
	get_node("/root/Main/Projectiles").add_child(bullet_instance)
	get_node("/root/Main").play_sound("ShootLight")
