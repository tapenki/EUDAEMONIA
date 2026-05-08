extends Camera2D

var shake = 0.0

func _ready() -> void:
	get_node("/root/Main").update_cam.connect(update_cam)
	get_node("/root/Main").screenshake.connect(screenshake)
	get_node("/root/Main").failed.connect(defeat)
	Config.value_changed.connect(
		func(section, key):
			if section == "display" and key == "camera_zoom":
				update_cam()
	)
	update_cam()

func _process(delta):
	if shake:
		shake = max(shake - delta, 0)
		var amount = pow(shake, 2) * Config.config.get_value("gameplay", "screenshake")
		offset.x = 90 * amount * randf_range(-1, 1)
		offset.y = 60 * amount * randf_range(-1, 1)

func update_cam():
	zoom = Vector2(1, 1)
	zoom *= Config.config.get_value("display", "camera_zoom")
	zoom *= SphereData.room_data[get_node("/root/Main").room]["zoom_scale"]

func screenshake(intensity):
	shake = intensity

func defeat():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUART)
	tween.tween_property(self, "zoom", zoom * 0.5, 60)
	reparent(get_node("/root/Main"))
