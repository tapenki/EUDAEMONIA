extends Label

func _ready() -> void:
	get_node("/root/Main").intermission.connect(update.unbind(1))
	update()

func update():
	if get_node("/root/Main").loop > 0:
		text = "%s - %s - %s" % [
			tr("land_of_"+SphereData.room_data[get_node("/root/Main").room].get("land")+"_title"),
			tr("day_counter") % get_node("/root/Main").day,
			tr("loop_counter") % get_node("/root/Main").loop
		]
	else:
		text = "%s - %s" % [
			tr("land_of_"+SphereData.room_data[get_node("/root/Main").room].get("land")+"_title"),
			tr("day_counter") % get_node("/root/Main").day
		]
