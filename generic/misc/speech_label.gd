extends Label

@onready var lifetime = $Lifetime

var typer: float
var speed = 20

func _physics_process(delta: float) -> void:
	if visible_characters < get_total_character_count():
		typer += delta * speed
		visible_characters = floor(typer)
	elif lifetime.is_stopped():
		lifetime.start()
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_EXPO)
		tween.tween_property(self, "modulate", Color(1,1,1,0), lifetime.wait_time)

func kill():
	queue_free()
