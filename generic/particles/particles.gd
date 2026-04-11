class_name Particles extends GPUParticles2D
## TODO particles with finite visibility rect cause visual issues when scaled to 0 
## particles with infinite visibility rect cause visual issues when rotated

@onready var timer = $Lifetime
@export var ability_relay: Node

func _ready() -> void:
	if ability_relay:
		ability_relay.self_death.connect(self_death)

func self_death():
	kill()
	modulate *= get_parent().modulate
	reparent(get_node("/root/Main/Effects"))

func kill():
	emitting = false
	timer.start()

 # finished signal is broken or something
func _on_lifetime_timeout() -> void:
	queue_free()
