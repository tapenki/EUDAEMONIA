extends GPUParticles2D

@onready var timer = $Lifetime

func parent_died():
	kill()
	reparent(get_tree().current_scene)

func kill():
	emitting = false
	timer.start()

 # finished signal is broken or something
func _on_lifetime_timeout() -> void:
	queue_free()
