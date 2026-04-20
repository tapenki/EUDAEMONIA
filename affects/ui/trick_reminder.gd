extends Described

@onready var symbol_label: = $"Symbol"
@onready var keybind_label: = $"Bind"

func _ready() -> void:
	symbol_label.text = subject.substr(0, 2).capitalize()
	Utils.controls_changed.connect(controls_changed)
	controls_changed(subject)

func controls_changed(action):
	if action == subject:
		keybind_label.text = "[%s]" % InputMap.action_get_events(subject)[0].as_text()
	for description_node in description_nodes:
		if action == description_node.subject:
			description_node.set_description(get_description_text(description_node.subject))
