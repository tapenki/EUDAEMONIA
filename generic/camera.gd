extends Camera2D

var shake = 0.0

func _process(delta):
	if shake:
		shake = max(shake - delta, 0)
		var amount = pow(shake, 2)
		offset.x = 90 * amount * randf_range(-1, 1)
		offset.y = 60 * amount * randf_range(-1, 1)
