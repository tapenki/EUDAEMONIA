extends Label

@onready var ui = get_node("/root/Main/UI")

func _ready() -> void:
	get_node("/root/Main").day_cleared.connect(update)
	update(0)
	
func update(_day):
	text = "%s / %s" % [tr("unlock_point_counter") % ui.unlock_points, tr("upgrade_point_counter") % ui.upgrade_points]
