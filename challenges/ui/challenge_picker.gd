extends Described

@onready var symbol_label: = $"Symbol"

var selected: bool

func _ready() -> void:
	symbol_label.text = subject.substr(0, 2).capitalize()
	if ui.challenges.has(subject):
		selected = true
		self_modulate = Color.WHITE
		symbol_label.self_modulate = Color.WHITE
		tag = "selected"

func _on_pressed() -> void:
	if selected:
		selected = false
		ui.challenges.erase(subject)
		self_modulate = Color("7f7f7f")
		symbol_label.self_modulate = Color("7f7f7f")
		tag = ""
	else:
		selected = true
		ui.challenges.append(subject)
		self_modulate = Color.WHITE
		symbol_label.self_modulate = Color.WHITE
		tag = "selected"
	if description_nodes.size() > 0:
		description_nodes[0].set_tag(tag)
