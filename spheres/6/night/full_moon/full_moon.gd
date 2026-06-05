extends Ability

func apply(ability_relay, applicant_data):
	ability_relay.crit_chance_modifiers.connect(crit_chance_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.crit_chance_modifiers.is_connected(crit_chance_modifiers):
		ability_relay.crit_chance_modifiers.disconnect(crit_chance_modifiers)

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)

func day_start(day: int) -> void:
	if day % 4 == 0:
		var room = get_node("/root/Main").room_node
		if is_instance_valid(room) and room.has_node("Doors"):
			for door in room.get_node("Doors").get_children():
				if door.has_node("HintParticles"):
					door.get_node("HintParticles").emitting = true
					door.get_node("HintParticles").amount = 4

func crit_chance_modifiers(_entity, crit) -> void:
	if get_node("/root/Main").day % 4 == 0:
		crit["base"] += 100
