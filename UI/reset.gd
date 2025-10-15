extends Button

@onready var ui = $"../.."

var held: bool
var hold_timer: float
var offset: Vector2

func down():
	held = true

func up():
	held = false
	hold_timer = 0
	position -= offset
	offset = Vector2()

func _process(delta: float) -> void:
	if held:
		hold_timer += delta
		if hold_timer >= 0.5:
			ui.reset()
		position -= offset
		offset = Vector2(randf_range(-2, 2), randf_range(-2, 2))
		position += offset
