extends CanvasItem

func _physics_process(_delta: float) -> void:
	self_modulate = Color.WHITE * (1 - sin(Time.get_ticks_msec()*0.02) * 0.33)
