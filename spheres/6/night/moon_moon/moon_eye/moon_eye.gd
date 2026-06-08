extends Entity

@export var max_distance: float
#@export var distance_deviation: float
@export var speed: float
#@export var speed_deviation: float

var orbited_relay: Node

var distance: float
var offset: Vector2
var orbitation: float

var loose: bool

var alarm = 0.0

func _ready() -> void:
	super()
	var lifetime = get_node("Lifetime")
	lifetime.wait_time *= ability_relay.get_effect_duration()
	orbited_relay.damage_taken.connect(damage_taken)
	#orbitation = randf() * TAU
	#max_distance = max_distance * (1 + randf_range(-1, 1) * distance_deviation)
	#speed = speed * (1 + randf_range(-1, 1) * speed_deviation)

func movement(delta):
	var old_position = global_position
	
	var alarm_multiplier = 1.0
	if alarm > 0:
		alarm -= delta * ability_relay.speed_scale
		alarm_multiplier = 4.0
	
	if loose:
		distance += speed * delta * ability_relay.speed_scale * alarm_multiplier / 2
		orbitation += speed * delta * ability_relay.speed_scale * alarm_multiplier / max(distance, 50)
	else:
		distance = min(max_distance, distance + speed * delta * ability_relay.speed_scale * orbited_relay.speed_scale * alarm_multiplier / 2)
		orbitation += speed * delta * ability_relay.speed_scale * orbited_relay.speed_scale * alarm_multiplier / max(distance, 50)
	
	rotation = orbitation
	
	position -= offset
	offset = Vector2.from_angle(orbitation) * distance
	position += offset
	
	ability_relay.movement.emit(old_position.distance_to(global_position))

func damage_taken(_damage) -> void:
	alarm = ability_relay.get_effect_duration()

func loosen():
	loose = true
	reparent(get_node("/root/Main/Entities"), true)
	get_node("Lifetime").start()

func _on_lifetime_timeout() -> void:
	kill()
