extends Described

func _ready() -> void:
	get_node("../Appearance").emitting = true

func _on_pressed() -> void:
	if get_node("/root/Main").game_over:
		get_node("/root/Main").play_sound("Error")
		return
	visible = false
	get_node("/root/Main/UI").unlock_points += 1
	get_node("/root/Main/UI/GameMenu/UpgradePoints").update()
	get_node("/root/Main").play_sound("Click")
	get_node("../Particles").emitting = false
	await get_tree().create_timer(1).timeout
	get_parent().queue_free()
