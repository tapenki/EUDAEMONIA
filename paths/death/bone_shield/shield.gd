extends Entity

var distance = 50.0
var angle = 0.0

var offset: Vector2

func movement(delta):
	var desired_rotation = (get_global_mouse_position() - get_parent().global_position).angle() + angle
	rotation = rotate_toward(rotation - PI * 0.5, desired_rotation, 16.0 * delta * ability_handler.speed_scale) + PI * 0.5
	
	position -= offset
	offset = Vector2.from_angle(rotation - PI * 0.5) * distance
	position += offset
