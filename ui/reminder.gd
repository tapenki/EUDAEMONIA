extends Described

@onready var symbol_label: = $"Symbol"

func _ready() -> void:
	symbol_label.text = subject.substr(0, 2).capitalize()
