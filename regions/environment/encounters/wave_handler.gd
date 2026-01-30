extends Node2D

@export var first_wave: Node

func _ready() -> void:
	first_wave.start()
