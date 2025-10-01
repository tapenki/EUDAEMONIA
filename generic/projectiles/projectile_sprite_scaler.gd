extends Node2D

@export var ability_handler: Node
@export var scaler = 0.1
@export var max_scaler = 1.0
@export var grow = 5.0
@export var shrink = 5.0

var base_scale = Vector2(1, 1)
var alive = true

func _ready() -> void:
	ability_handler.self_death.connect(parent_died)
	scale = base_scale * scaler

func _physics_process(delta: float) -> void:
	if alive:
		scaler = min(scaler + grow * delta * ability_handler.speed_scale, max_scaler)
	else:
		scaler = max(scaler - shrink * delta, 0)
		if scaler == 0:
			queue_free()
	scale = base_scale * scaler

func parent_died():
	base_scale = get_parent().global_scale
	reparent(get_tree().current_scene)
	alive = false
