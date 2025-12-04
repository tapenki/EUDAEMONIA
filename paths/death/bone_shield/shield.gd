extends Entity

var distance = 50.0
var offset: Vector2

func movement(delta):
	var desired_rotation
	if get_index() > 0:
		desired_rotation = get_parent().get_child(get_index()-1).rotation - PI * 0.5
	else:
		desired_rotation = (get_global_mouse_position() - get_parent().global_position).angle()
	rotation = rotate_toward(rotation - PI * 0.5, desired_rotation, (750.0 / distance + 2.5) * delta * ability_handler.speed_scale) + PI * 0.5
	
	position -= offset
	offset = Vector2.from_angle(rotation - PI * 0.5) * distance
	position += offset
