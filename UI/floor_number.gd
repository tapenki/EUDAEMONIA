extends Label

func _ready() -> void:
	get_node("/root/Main").intermission.connect(update.unbind(1))
	update()

func update():
	print(get_node("/root/Main").room)
	text = "%s - %s" % [
		tr(SphereData.room_data[get_node("/root/Main").room].get("region", "pandemonium")+"_title"),
		tr("day_counter") % get_node("/root/Main").day
	]
