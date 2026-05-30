extends Ability

var bullet = preload("res://paths/time/shard.tscn")

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 3:
		var hand = Sprite2D.new()
		hand.texture = preload("res://paths/time/clock_hand.png")
		hand.offset.y = -50
		hand.modulate = Config.get_team_color(ability_relay.owner.group, "secondary")
		ability_relay.add_child(hand)
		applicant_data["hand"] = hand
		applicant_data["time"] = 0.0
	elif applicant_data.has("hour_hand"):
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	elif applicants.has(ability_relay.source) and applicants[ability_relay.source].has("hour_hand"):
		applicant_data["hour_hand"] = applicants[ability_relay.source]["hour_hand"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	if applicants.has(ability_relay) and applicants[ability_relay].has("hand"):
		applicants[ability_relay]["hand"].queue_free()
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func _ready() -> void:
	get_node("/root/Main").intermission.connect(intermission)

func intermission(_day: int) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("time"):
			applicants[ability_relay]["time"] = 0.0

func _physics_process(delta: float) -> void:
	for applicant in applicants:
		if applicants[applicant].has("time"):
			applicants[applicant]["time"] += delta * applicant.speed_scale / 4
			if applicants[applicant]["time"] > 1:
				applicants[applicant]["time"] = fmod(applicants[applicant]["time"], 1)
				for i in 12:
					var direction = Vector2.from_angle(TAU / 12 * i)
					var bullet_instance = applicant.make_projectile(bullet, 
					applicant.global_position + direction * 25, 
					{"subscription" = 2, "hour_hand" = true},
					direction * 600)
					get_node("/root/Main/Projectiles").add_child(bullet_instance)
			applicants[applicant]["hand"].rotation = applicants[applicant]["time"] * TAU

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["multiplier"] *= 3
