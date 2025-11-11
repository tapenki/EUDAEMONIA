extends Described

@onready var ui = get_node("/root/Main/UI")
@onready var symbol_label: = $"Symbol"

func _ready() -> void:
	symbol_label.text = name.substr(0, 2).capitalize()
