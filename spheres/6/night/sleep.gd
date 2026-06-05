extends Node2D

@onready var ability_relay = get_node("%AbilityRelay")
@onready var particles = get_node("Particles")

@export var sense_range_mult = 1.0

var active = true

func _ready() -> void:
	modulate = Config.get_team_color(owner.group, "secondary")
	var scale_mult = (1 - sin(Time.get_ticks_msec()*0.001) * 0.1) * sense_range_mult
	get_node("Sprite2D").scale = Vector2(1, 1) * scale_mult
	ability_relay.speed_scale_modifiers.connect(speed_scale_modifiers)
	ability_relay.damage_taken.connect(awaken.unbind(1))
	ability_relay.self_death.connect(awaken)

func _physics_process(_delta: float) -> void:
	if active:
		var scale_mult = (1 - sin(Time.get_ticks_msec()*0.001) * 0.1) * sense_range_mult
		get_node("Sprite2D").scale = Vector2(1, 1) * scale_mult
		var enemies = ability_relay.area_targets(global_position, 100 * scale_mult)
		if enemies:
			awaken()

func speed_scale_modifiers(modifiers) -> void:
	if active:
		#var slow = ability_relay.get_incoming_slow()
		modifiers["multiplier"] *= 0#1 - slow

func awaken():
	if active:
		get_node("/root/Main").floating_text(global_position, "[!]", modulate)
		active = false
		particles.emitting = false
		var tween = create_tween()
		tween.tween_property(get_node("Sprite2D"), "self_modulate", Color(1,1,1,0), 0.1)
