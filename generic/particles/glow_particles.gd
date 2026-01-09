extends Particles

func kill():
	super()
	var tween = create_tween()
	tween.tween_property(get_node("Glow"), "self_modulate:a", 0, timer.wait_time)
