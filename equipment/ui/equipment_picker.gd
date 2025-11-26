extends Described

@onready var symbol_label: = $"Symbol"

@export_enum("weapon", "armor", "trick") var type: String

var selected: bool

func _ready() -> void:
	symbol_label.text = subject.substr(0, 2).capitalize()
	if ui[type] == subject:
		self_modulate = Color.WHITE
		symbol_label.self_modulate = Color.WHITE
		tag = "selected"

func deselect():
	self_modulate = Color("7f7f7f")
	symbol_label.self_modulate = Color("7f7f7f")
	tag = ""

func _on_pressed() -> void:
	if not selected:
		var selected_equip = get_node("../" + ui[type])
		selected_equip.deselect()
		ui[type] = subject
		self_modulate = Color.WHITE
		symbol_label.self_modulate = Color.WHITE
		tag = "selected"
		if description_nodes.size() > 0:
			description_nodes[0].set_tag(tag)
			
