extends Described

@onready var ui = get_node("/root/Main/UI")
@onready var symbol_label: = $"Symbol"

@export_enum("weapon", "armor", "trick") var type: String

var selected: bool

func _ready() -> void:
	symbol_label.text = name.substr(0, 2)
	if ui[type] == subject:
		self_modulate = Color.WHITE
		symbol_label.self_modulate = Color.WHITE
		extra = "selected"

func deselect():
	self_modulate = Color("7f7f7f")
	symbol_label.self_modulate = Color("7f7f7f")
	extra = ""

func _on_pressed() -> void:
	if not selected:
		var selected_equip = get_node("../" + ui[type])
		selected_equip.deselect()
		ui[type] = subject
		self_modulate = Color.WHITE
		symbol_label.self_modulate = Color.WHITE
		extra = "selected"
		_on_mouse_entered()
