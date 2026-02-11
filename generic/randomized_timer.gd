class_name RandomizedTimer extends Node

@export var wait_time = 1.0
@export var deviation = 0.0
@onready var time_left = wait_time

@export var one_shot = true
@export var running = false
@export var ability_handler: Node

signal timeout()

func _process(delta: float) -> void:
	if running:
		time_left -= delta * ability_handler.speed_scale
		if time_left <= 0:
			if one_shot:
				running = false
			else:
				time_left += wait_time * (1 + randf_range(-1, 1) * deviation)
			timeout.emit()

func start(time = wait_time):
	wait_time = time
	time_left = time * (1 + randf_range(-1, 1) * deviation)
	running = true
