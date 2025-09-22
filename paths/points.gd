extends Label

@onready var ui = $"../../../"

func _ready() -> void:
	get_node("/root/Main").day_cleared.connect(update)
	update(1)
	
func update(_day):
	text = tr("upgrade_point_counter") % ui.upgrade_points
