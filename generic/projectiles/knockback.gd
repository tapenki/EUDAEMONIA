extends Node2D

@onready var ability_relay = %AbilityRelay

@export var intensity = 1.0

func _ready() -> void:
	ability_relay.damage_dealt.connect(damage_dealt)

func damage_dealt(entity, damage) -> void:
	var direction
	if damage.has("direction"):
		direction = damage["direction"]
	else:
		direction = ability_relay.global_position.direction_to(entity.global_position)
	ability_relay.apply_knockback(entity, direction, intensity)
