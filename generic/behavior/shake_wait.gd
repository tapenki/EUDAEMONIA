extends State

@onready var timer = $"Timer"

@export var intensity: int
var sprite_position: Vector2

@export var next: State

func on_enter() -> void:
	var sprite = user.get_node("Sprite")
	sprite_position = sprite.position
	user.velocity = Vector2()
	timer.start()
	super()

func on_exit() -> void:
	var sprite = user.get_node("Sprite")
	sprite.position = sprite_position
	super()

func _physics_process(_delta):
	var sprite = user.get_node("Sprite")
	sprite.position = sprite_position + Vector2(randf_range(-intensity, intensity), randf_range(-intensity, intensity))

func _on_timer_timeout() -> void:
	state_handler.change_state(next)
