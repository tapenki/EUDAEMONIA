extends Entity

var offset: Vector2

func movement(_delta):
	rotation = (get_global_mouse_position() - get_parent().global_position).angle()
	
	position -= offset
	offset = Vector2.from_angle(rotation) * 50
	position += offset
