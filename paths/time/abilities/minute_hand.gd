extends Ability

var second_boost = 0.0

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 3:
		var hand = Sprite2D.new()
		hand.texture = preload("res://paths/time/clock_hand.png")
		hand.scale *= 1.2
		hand.offset.y = -50
		hand.modulate = Config.get_team_color(ability_relay.owner.group, "secondary")
		ability_relay.add_child(hand)
		applicant_data["hand"] = hand
		applicant_data["time"] = 0.0
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
	second_boost = 0.0

func _physics_process(delta: float) -> void:
	for applicant in applicants:
		if applicants[applicant].has("time"):
			var speed_mult = 1
			var clockwinding = ability_handler.get_node_or_null("clockwinding")
			if clockwinding:
				speed_mult += 0.1 * clockwinding.level
			applicants[applicant]["time"] += delta * applicant.speed_scale * speed_mult / 2
			if applicants[applicant]["time"] > 1:
				second_boost += floor(applicants[applicant]["time"]) * level * 0.5
				applicants[applicant]["time"] = fmod(applicants[applicant]["time"], 1)
			applicants[applicant]["hand"].rotation = applicants[applicant]["time"] * TAU

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += second_boost
