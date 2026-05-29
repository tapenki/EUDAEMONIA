extends Described

@onready var symbol_label: = $"Symbol"
@onready var keybind_label: = $"Bind"
@onready var level_label: = $"Level"

func _ready() -> void:
	symbol_label.text = subject.substr(0, 2).capitalize()
	Utils.controls_changed.connect(controls_changed)
	get_node_or_null("/root/Main/PlayerAbilityHandler").abilities_changed.connect(abilities_changed)
	controls_changed(subject)
	abilities_changed()

func abilities_changed():
	var ability_node = get_node_or_null("/root/Main/PlayerAbilityHandler/"+subject)
	if ability_node:
		level_label.text = "[%s]" % int(ability_node.level)

func controls_changed(action):
	if action == subject:
		keybind_label.text = "[%s]" % InputMap.action_get_events(subject)[0].as_text()
	for description_node in description_nodes:
		if action == description_node.subject:
			description_node.set_description(get_description_text(description_node.subject))
