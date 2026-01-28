extends Ability

func _physics_process(delta: float) -> void:
	level += delta
	if level >= 60:
		level -= 60
		get_node("/root/Main").day += 1
		get_node("/root/Main/UI/HUD/FloorNumber").update()

func inherit(_handler, _tier):
	return
