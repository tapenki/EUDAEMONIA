extends Wave

func wave_cleared():
	get_node("/root/Main").full_clear()
	timer.stop()
