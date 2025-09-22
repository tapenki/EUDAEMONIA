extends Described

@onready var ui = $"../../../../../"
@onready var player = $"../../../../../".player
@onready var ability_handler = player.get_node("AbilityHandler")

@onready var point_counter = $"../../../Level"

@onready var level_label: = $"Level"
@onready var symbol_label: = $"Symbol"

@export var ability_script: Script

func _ready() -> void:
	#rotation_degrees = randf_range(-5, 5)
	symbol_label.text = subject.substr(0, 2)

func _on_pressed() -> void:
	if ui.upgrade_points >= 1:
		ui.upgrade_points -= 1
		ability_handler.upgrade(ability_script, subject, 1)
		point_counter.update(0)
		var ability_node = ability_handler.get_node_or_null(subject)
		if ability_node:
			self_modulate = Color.WHITE
			symbol_label.self_modulate = Color.WHITE
			level_label.text = str(int(ability_node.level))
