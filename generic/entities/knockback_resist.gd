extends Node2D

@onready var ability_relay = %AbilityRelay

@export var value = 0.0

func _ready() -> void:
	ability_relay.knockback_taken_modifiers.connect(knockback_taken_modifiers)

func knockback_taken_modifiers(knockback) -> void:
	knockback["multiplier"] *= value
