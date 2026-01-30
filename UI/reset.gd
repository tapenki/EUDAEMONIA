extends Button

@onready var ui = get_node("/root/Main/UI")
@onready var hint = $"Hint"

var held: bool
var hold_timer: float
var offset: Vector2

func _process(delta: float) -> void:
	if held:
		get_node("/root/Main").play_sound("Click", 0.8 + hold_timer * 2)
		hold_timer += delta
		if hold_timer >= 0.5:
			ui.reset()
		position -= offset
		offset = Vector2(randf_range(-2, 2), randf_range(-2, 2))
		position += offset

func down():
	held = true

func up():
	hint.visible = false
	held = false
	hold_timer = 0
	position -= offset
	offset = Vector2()

func _on_mouse_entered() -> void:
	hint.visible = true
