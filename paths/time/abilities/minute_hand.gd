extends Ability

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] >= 3:
		var hand = Sprite2D.new()
		hand.texture = preload("res://paths/time/clock_hand.png")
		hand.offset.y = -50
		hand.modulate = Config.get_team_color(ability_relay.owner.group, "secondary")
		ability_relay.add_child(hand)
		applicant_data["hand"] = hand
		applicant_data["minute_boost"] = 0.0
		applicant_data["time"] = 0.0
	ability_relay.max_health_modifiers.connect(max_health_modifiers.bind(ability_relay))
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	if applicants.has(ability_relay) and applicants[ability_relay].has("hand"):
		applicants[ability_relay]["hand"].queue_free()
	super(ability_relay)
	if ability_relay.max_health_modifiers.is_connected(max_health_modifiers):
		ability_relay.max_health_modifiers.disconnect(max_health_modifiers)

func _ready() -> void:
	get_node("/root/Main").intermission.connect(intermission)

func intermission(_day: int) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("time"):
			applicants[ability_relay]["minute_boost"] = 0.0
			applicants[ability_relay]["time"] = 0.0
			ability_handler.abilities_changed.emit()

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("time"):
			var speed_mult = 1
			var clockwinding = ability_handler.get_node_or_null("clockwinding")
			if clockwinding:
				speed_mult += 0.1 * clockwinding.level
			applicants[ability_relay]["time"] += delta * ability_relay.speed_scale * speed_mult / 3
			if applicants[ability_relay]["time"] > 1:
				applicants[ability_relay]["minute_boost"] += floor(applicants[ability_relay]["time"]) * level * 2
				applicants[ability_relay]["time"] = fmod(applicants[ability_relay]["time"], 1)
				ability_handler.abilities_changed.emit()
			applicants[ability_relay]["hand"].rotation = applicants[ability_relay]["time"] * TAU

func max_health_modifiers(modifiers, ability_relay) -> void:
	if applicants.has(ability_relay) and applicants[ability_relay].has("minute_boost"):
		modifiers["base"] += applicants[ability_relay]["minute_boost"]
