extends Entity

@export var max_distance: float
@export var distance_deviation: float
@export var speed: float
@export var speed_deviation: float

var distance: float
var offset: Vector2

var loose: bool

func _ready() -> void:
	super()
	rotation = randf() * TAU
	max_distance = max_distance * (1 + randf_range(-1, 1) * distance_deviation)
	speed = speed * (1 + randf_range(-1, 1) * speed_deviation)

func movement(delta):
	var old_position = global_position
	
	if loose:
		distance += speed * delta * ability_handler.speed_scale / 2
	else:
		distance = min(max_distance, distance + speed * delta * ability_handler.speed_scale / 2)
	
	rotation += speed * delta * ability_handler.speed_scale / distance
	
	position -= offset
	offset = Vector2.from_angle(rotation) * distance
	position += offset
	
	ability_handler.movement.emit(old_position.distance_to(global_position))

func loosen():
	loose = true
	reparent(get_node("/root/Main/Entities"), true)
	get_node("Lifetime").start()

func _on_lifetime_timeout() -> void:
	kill()
