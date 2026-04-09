extends Reminder

@onready var level_label: = $"Level"

func _ready() -> void:
	super()
	ui.update_abilities.connect(update)
	update()

func update():
	var ability_node = get_node_or_null("/root/Main/PlayerAbilityHandler/"+subject)
	if ability_node:
		level_label.text = "[%s]" % int(ability_node.level)
