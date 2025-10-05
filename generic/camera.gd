extends Camera2D

var shake = 0.0

func _ready() -> void:
	get_node("/root/Main").camera_parameters.connect(set_parameters)
	get_node("/root/Main").screenshake.connect(screenshake)
	get_node("/root/Main").failed.connect(defeat)

func _process(delta):
	if shake:
		shake = max(shake - delta, 0)
		var amount = pow(shake, 2) * Config.config.get_value("gameplay", "screenshake")
		offset.x = 90 * amount * randf_range(-1, 1)
		offset.y = 60 * amount * randf_range(-1, 1)

func set_parameters(zoom_scale = 1):#, left = 0, top = 0, right = 900, bottom = 600):
	zoom = Vector2(1, 1) * zoom_scale
	#limit_left = left
	#limit_top = top
	#limit_right = right
	#limit_bottom = bottom

func screenshake(intensity):
	shake = intensity

func defeat():
	var tween = create_tween()
	tween.tween_property(self, "zoom", zoom * 0.5, 15)
	reparent(get_node("/root/Main"))
