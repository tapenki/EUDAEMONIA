extends Sprite2D

@export var ability_handler: Node

func _physics_process(delta):
	rotation += TAU * delta * ability_handler.speed_scale;
