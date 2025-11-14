class_name ScaledTimer extends Node

@export var wait_time = 1.0
@onready var time_left = 0.0

@export var one_shot = true
@export var running = false
@export var ability_handler: Node

signal timeout()

func _ready() -> void:
	if running:
		time_left = wait_time

func _process(delta: float) -> void:
	if running:
		time_left -= delta * ability_handler.speed_scale
		if time_left <= 0:
			timeout.emit()
			if one_shot:
				running = false
			else:
				time_left += wait_time

func start(time = wait_time):
	wait_time = time
	time_left = time
	running = true
