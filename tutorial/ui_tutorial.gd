extends UIGame

func _process(_delta: float) -> void:
	super(_delta)
	if not main.game_over:
		if upgrade_points == 0 and not main.day_started and Time.get_ticks_msec() % 400 < 200:
			proceed.get_node("NinePatchRect").texture = button_blue
		else:
			proceed.get_node("NinePatchRect").texture = button_gray
