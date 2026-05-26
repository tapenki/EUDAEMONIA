class_name Focusable extends Control

var highlight_scene = preload("res://ui/highlight.tscn")
var highlight_node: Node

func _on_focus_entered() -> void:
	var highlight_instance = highlight_scene.instantiate()
	add_child(highlight_instance)
	highlight_node = highlight_instance
	
func _on_focus_exited() -> void:
	if highlight_node:
		highlight_node.queue_free()
