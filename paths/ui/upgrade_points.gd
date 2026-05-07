extends UIScaler

@onready var ui = get_node("/root/Main/UI")

func _ready() -> void:
	super()
	get_node("/root/Main").intermission.connect(update_points.unbind(1))
	update_points()
	
func update_points():
	self.text = "%s / %s" % [tr("unlock_point_counter") % ui.unlock_points, tr("upgrade_point_counter") % ui.upgrade_points]
