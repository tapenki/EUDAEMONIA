extends Described

@onready var player = get_node("/root/Main/UI").player
@onready var ability_relay = player.get_node("AbilityRelay")

@onready var point_counter = get_node("/root/Main/UI/GameMenu/UpgradePoints")

@onready var level_label: = $"Level"
@onready var symbol_label: = $"Symbol"

@export var cost = 1

func _ready() -> void:
	#rotation_degrees = randf_range(-5, 5)
	symbol_label.text = name.substr(0, 2)
	var ability_node = get_node_or_null("/root/Main/PlayerAbilityHandler/"+subject)
	if ability_node:
		self_modulate = Color.WHITE
		symbol_label.self_modulate = Color.WHITE
		level_label.text = "[%s]" % int(ability_node.level)

func _on_pressed() -> void:
	if not get_node("/root/Main").game_over and ui.upgrade_points >= cost:
		ui.upgrade_points -= cost
		get_node("/root/Main/PlayerAbilityHandler").learn(subject, 1)
		point_counter.update()
		var ability_node = get_node_or_null("/root/Main/PlayerAbilityHandler/"+subject)
		if ability_node:
			self_modulate = Color.WHITE
			symbol_label.self_modulate = Color.WHITE
			level_label.text = "[%s]" % int(ability_node.level)
		get_node("/root/Main").play_sound("Click")
	else:
		get_node("/root/Main").play_sound("Error")
