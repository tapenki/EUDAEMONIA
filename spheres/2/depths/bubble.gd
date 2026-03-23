extends Sprite2D

func _physics_process(_delta: float) -> void:
	scale = Vector2(0.8, 0.8) * (1 - sin(Time.get_ticks_msec()*0.005) * 0.1)
