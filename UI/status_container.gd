extends GridContainer

@onready var player = $"../../".player
@onready var ability_handler = player.ability_handler

var status_label = preload("res://ui/status_label.tscn")

#func _ready() -> void:
	#ability_handler.update_status.connect(update)

func update(status):
	var label = get_node_or_null(NodePath(status.name))
	if status.level > 0:
		if label == null:
			label = status_label.instantiate()
			label.name = status.name
			add_child(label)
		label.text = "%s (%s)" % [status.name, status.level]
	else:
		if label != null:
			label.queue_free()
