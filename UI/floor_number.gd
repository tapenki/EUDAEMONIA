extends Label

func _ready() -> void:
	get_node("/root/Main").intermission.connect(update)
	update(1)

func update(day):
	text = "%s - %s" % [
		tr(get_node("/root/Main").sphere+"_title"),
		tr("day_counter") % day
	]
