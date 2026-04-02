extends BoxContainer

var message_scene = preload("res://ui/misc/message.tscn")

func print_message(text: String):
	var message_node = message_scene.instantiate()
	message_node.text = text
	add_child(message_node)
	await message_node.get_node("Lifetime").timeout
	var fade_tween = create_tween()
	fade_tween.tween_property(message_node, "modulate", Color(1,1,1,0), 0.1)
	await fade_tween.finished
	message_node.queue_free()
