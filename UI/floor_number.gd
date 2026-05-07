extends UIScaler

func _ready() -> void:
	super()
	get_node("/root/Main").intermission.connect(update_floor.unbind(1))
	update_floor()

func update_floor():
	if get_node("/root/Main").loop > 0:
		self.text = "%s - %s - %s" % [
			tr("land_of_"+SphereData.room_data[get_node("/root/Main").room].get("land")+"_title"),
			tr("day_counter") % get_node("/root/Main").day,
			tr("loop_counter") % get_node("/root/Main").loop
		]
	else:
		self.text = "%s - %s" % [
			tr("land_of_"+SphereData.room_data[get_node("/root/Main").room].get("land")+"_title"),
			tr("day_counter") % get_node("/root/Main").day
		]
