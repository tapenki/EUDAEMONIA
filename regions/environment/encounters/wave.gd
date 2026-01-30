class_name Wave extends Node2D

@onready var timer = $Timer

@export var autostart: bool
@export var next: Wave

func _ready() -> void:
	if autostart:
		start()

func start():
	if next:
		timer.start()
	get_node("/root/Main").wave_cleared.connect(wave_cleared)
	get_node("/root/Main").wave_start.emit(self)

func proceed():
	get_node("/root/Main").wave_cleared.disconnect(wave_cleared)
	next.start()

func wave_cleared():
	if not next:
		get_node("/root/Main").day_cleared.emit(get_node("/root/Main").day)
	elif timer.time_left > 0.5:
		timer.start(0.5)
	
