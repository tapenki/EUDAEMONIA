class_name WaitState extends State

@onready var timer = $"Timer"

@export var anim: String

@export var next: State

func on_enter() -> void:
	super()
	if anim != "":
		if user.animation_player.current_animation == anim:
			user.animation_player.stop()
		user.animation_player.play(anim)
	timer.start()

#func on_exit() -> void:
	#user.animation_player.play("RESET")
	#super()

func _on_timer_timeout() -> void:
	state_handler.change_state(next)
