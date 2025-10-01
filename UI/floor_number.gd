extends Label

func _ready() -> void:
	get_node("/root/Main").intermission.connect(update)
	update(0)

func update(_day):
	text = "%s - %s" % [
		tr(get_node("/root/Main").region+"_title"),
		tr("day_counter") % get_node("/root/Main").day
	]
