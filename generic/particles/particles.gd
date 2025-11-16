extends GPUParticles2D

@onready var timer = $Lifetime
@export var ability_handler: Node

func _ready() -> void:
	if ability_handler:
		ability_handler.self_death.connect(self_death)

func self_death():
	kill()
	modulate *= get_parent().modulate
	reparent(get_tree().current_scene)

func kill():
	emitting = false
	timer.start()

 # finished signal is broken or something
func _on_lifetime_timeout() -> void:
	queue_free()
