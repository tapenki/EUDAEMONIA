extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _physics_process(delta: float) -> void:
	level += delta
	if level >= 30:
		level -= 30
		get_node("/root/Main").day += 1
		get_node("/root/Main/UI/HUD/FloorNumber").update()
