extends Sprite2D

@export var ability_relay: Node
@export var speed = 1.0

func _physics_process(delta):
	rotation += TAU * speed * delta * ability_relay.speed_scale;
