extends Node2D

@onready var ability_relay = get_node("%AbilityRelay")

var sightlines: Dictionary

var alarm = 0.0

func _ready() -> void:
	for sightline in get_children():
		sightlines[sightline] = 0.0
	ability_relay.damage_taken.connect(damage_taken)

func _physics_process(delta: float) -> void:
	for sightline in sightlines:
		if alarm > 0.0:
			sightline.rotation += delta * ability_relay.speed_scale * PI
			alarm -= delta
		else:
			sightline.rotation += delta * ability_relay.speed_scale * PI * 0.25

func damage_taken(_damage) -> void:
	alarm = ability_relay.get_effect_duration()
