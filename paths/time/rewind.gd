extends Described

var active = false

func _on_pressed() -> void:
	if active:
		get_node("/root/Main").play_sound("Click")
	else:
		get_node("/root/Main").play_sound("Error")
