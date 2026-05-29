extends Ability

func apply(ability_relay, applicant_data):
	if not applicant_data.has("subscription") or applicant_data["subscription"] >= 3:
		ability_relay.max_health_modifiers.connect(max_health_modifiers)
	ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.max_health_modifiers.is_connected(max_health_modifiers):
		ability_relay.max_health_modifiers.disconnect(max_health_modifiers)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)

func day_start(_day: int) -> void:
	var room = get_node("/root/Main").room_node
	if is_instance_valid(room) and room.has_node("Doors"):
		for door in room.get_node("Doors").get_children():
			if door.has_node("HintParticles"):
				door.get_node("HintParticles").amount = 16

func max_health_modifiers(modifiers) -> void:
	modifiers["base"] += 10 * get_node("/root/Main/UI").unlock_points

func damage_dealt_modifiers(_entity, modifiers) -> void:
	modifiers["base"] += 3 * get_node("/root/Main/UI").unlock_points
