extends GPUParticles2D

@export var ability_handler: Node
@export var scaler = 0.0
@export var max_scaler = 1.0
@export var grow = 5.0
@export var shrink = 5.0

var base_scale = Vector2(1, 1)
var old_scale = 1
var alive = true

func _ready() -> void:
	ability_handler.self_death.connect(parent_died)
	scale = base_scale * scaler

func _physics_process(delta: float) -> void:
	if alive:
		scaler = min(scaler + grow * delta * ability_handler.speed_scale, max_scaler)
		var attack_scale = ability_handler.get_attack_scale()
		process_material.scale /= old_scale
		process_material.scale *= attack_scale
		old_scale = attack_scale
	else:
		scaler = max(scaler - shrink * delta, 0)
		process_material.scale /= old_scale
		process_material.scale *= scaler
		old_scale = scaler
		if scaler == 0:
			queue_free()
	scale = base_scale * scaler

func parent_died():
	base_scale = get_parent().scale
	process_material.scale *= base_scale
	process_material.scale /= old_scale
	process_material.scale *= scaler
	old_scale = scaler
	reparent(get_tree().current_scene)
	alive = false
	emitting = false
