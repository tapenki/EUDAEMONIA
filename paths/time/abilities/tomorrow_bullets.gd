extends Ability

var freeze: Node

func apply(ability_relay, applicant_data):
	if ability_relay.is_projectile > 0:
		freeze.apply(ability_relay, {"duration" = 0.2 * level})
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func _ready() -> void:
	freeze = ability_handler.learn("freeze", 0)

func damage_dealt_modifiers(_entity, modifiers) -> void:
	#if ability_relay.speed_scale < 1:
	modifiers["multiplier"] *= 1 + (0.1 * level)
