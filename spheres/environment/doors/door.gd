class_name Door extends Sprite2D

@onready var button = $Button
@onready var particles = $Particles

@export var room: String
@export var door: String

@export var travel_time = 1

func _ready() -> void:
	get_node("/root/Main").day_cleared.connect(activate.unbind(1))

func activate():
	if get_node("/root/Main").game_over:
		return
	button.visible = true
	particles.emitting = true

func enter():
	get_node("/root/Main").day += travel_time
	get_node("/root/Main").travel(room, door)
