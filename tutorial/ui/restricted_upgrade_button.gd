extends TextureButton

func _on_pressed() -> void:
	get_node("/root/Main").play_sound("Error")
