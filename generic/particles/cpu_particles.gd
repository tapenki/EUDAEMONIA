class_name CpuParticles extends CPUParticles2D

@export var ability_relay: Node

func _ready() -> void:
	if ability_relay:
		ability_relay.self_death.connect(self_death)

func self_death():
	modulate *= get_parent().modulate
	reparent(get_node("/root/Main/Effects"))
	emitting = false
	notification(NOTIFICATION_INTERNAL_PROCESS) ## fix for reparent flicker
	await get_tree().create_timer(lifetime).timeout
	queue_free()
