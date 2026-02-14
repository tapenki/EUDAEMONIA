class_name CpuParticles extends CPUParticles2D

@export var ability_handler: Node

func _ready() -> void:
	if ability_handler:
		ability_handler.self_death.connect(self_death)

## TODO: particles flicker when reparented
func self_death():
	modulate *= get_parent().modulate
	reparent(get_tree().current_scene)
	emitting = false
	notification(NOTIFICATION_INTERNAL_PROCESS) ## fix for reparent flicker
	await get_tree().create_timer(lifetime).timeout
	queue_free()
