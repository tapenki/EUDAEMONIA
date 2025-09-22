extends Sprite2D

var entity: Node

func _on_spawn_timer_timeout() -> void:
	get_node("/root/Main/Entities").add_child(entity)
	queue_free()

func _physics_process(_delta: float) -> void:
	self_modulate = Color.WHITE * (1 - sin(Time.get_ticks_msec()*0.02) * 0.33)
