extends Described

@onready var ui = get_node("/root/Main/UI")
@onready var player = get_node("/root/Main/UI").player
@onready var ability_handler = player.get_node("AbilityHandler")

@onready var point_counter = $"../../../UpgradePoints"

@onready var level_label: = $"Level"
@onready var symbol_label: = $"Symbol"

func _ready() -> void:
	#rotation_degrees = randf_range(-5, 5)
	symbol_label.text = name.substr(0, 2)
	var ability_node = ability_handler.get_node_or_null(subject)
	if ability_node:
		self_modulate = Color.WHITE
		symbol_label.self_modulate = Color.WHITE
		level_label.text = "[%s]" % int(ability_node.level)

func _on_pressed() -> void:
	if not get_node("/root/Main").game_over and ui.upgrade_points >= 1:
		ui.upgrade_points -= 1
		ability_handler.upgrade(subject, 1)
		point_counter.update()
		var ability_node = ability_handler.get_node_or_null(subject)
		if ability_node:
			self_modulate = Color.WHITE
			symbol_label.self_modulate = Color.WHITE
			level_label.text = "[%s]" % int(ability_node.level)
