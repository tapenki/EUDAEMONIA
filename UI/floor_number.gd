extends Label

func _ready() -> void:
	get_node("/root/Main").intermission.connect(update.unbind(1))
	update()

func update():
	text = "%s - %s" % [
		tr(RegionData.room_data[get_node("/root/Main").room]["region"]+"_title"),
		tr("day_counter") % get_node("/root/Main").day
	]
