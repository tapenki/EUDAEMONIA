extends Node2D

@onready var ability_relay = get_node("%AbilityRelay")
@onready var particles = get_node("Particles")

var active = true

func _ready() -> void:
	particles.self_modulate = Config.get_team_color(owner.group, "secondary")
	ability_relay.speed_scale_modifiers.connect(speed_scale_modifiers)
	ability_relay.damage_taken.connect(damage_taken)

func speed_scale_modifiers(modifiers) -> void:
	if active:
		#var slow = ability_relay.get_incoming_slow()
		modifiers["multiplier"] *= 0#1 - slow

func damage_taken(_damage) -> void:
	awaken()

func awaken():
	if active:
		var color = Config.get_team_color(owner.group, "secondary")
		get_node("/root/Main").floating_text(global_position, "[!]", color)
		active = false
		particles.emitting = false
