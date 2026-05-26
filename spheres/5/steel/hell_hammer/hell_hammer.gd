extends Weapon

var explosion = preload("res://generic/projectiles/explosion.tscn")
const wait_time = 1.2

func apply(ability_relay, applicant_data):
	if applicant_data.has("hell_hammer"):
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	if applicants.has(ability_relay.source) and applicants[ability_relay.source].has("hell_hammer"):
		applicant_data["hell_hammer"] = applicants[ability_relay.source]["hell_hammer"]
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
	var explosion_instance = ability_relay.make_projectile(explosion, 
	ability_relay.global_position + direction * 100, 
	{"subscription" = 2, "weapon" = true, "hell_hammer" = true})
	explosion_instance.scale_multiplier = 1.5
	get_node("/root/Main/Projectiles").add_child(explosion_instance)
	get_node("/root/Main").play_sound("Explosion")

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += 20
