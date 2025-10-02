extends Node2D

func _ready() -> void:
	var rise_tween = create_tween()
	rise_tween.set_ease(Tween.EASE_OUT)
	rise_tween.set_trans(Tween.TRANS_QUART)
	rise_tween.tween_property(self, "position:y", -32, .5).as_relative()
	var grow_tween = create_tween()
	grow_tween.tween_property(self, "scale", Vector2(1, 2), 0.2)
	grow_tween.tween_property(self, "scale", Vector2(1, 1), 0.2)
	await get_tree().create_timer(0.5).timeout
	var shrink_tween = create_tween()
	shrink_tween.tween_property(self, "scale", Vector2(1, 0), 0.2)
	await shrink_tween.finished
	queue_free()
