extends Described

@onready var player = get_node("/root/Main/UI").player
@onready var ability_relay = player.get_node("AbilityRelay")

@onready var point_counter = get_node("/root/Main/UI/GameMenu/UpgradePoints")

@onready var texture_rect1: = $"TextureRect1"
@onready var texture_rect2: = $"TextureRect2"
@onready var symbol_label: = $"Symbol"

@export var accessible_texture: Texture2D
@export var requires: Dictionary

var accessible: bool

func _ready() -> void:
	get_node("/root/Main/PlayerAbilityHandler").abilities_changed.connect(update)
	update()

func update():
	var passed = true
	for ability in requires:
		var ability_node = get_node_or_null("/root/Main/PlayerAbilityHandler/"+ability)
		if not ability_node or ability_node.level < requires[ability]:
			passed = false
			break
	
	if passed:
		texture_rect1.texture = accessible_texture
		texture_rect2.texture = accessible_texture
		symbol_label.text = name.substr(0, 2)
		accessible = true
		var ability_node = get_node_or_null("/root/Main/PlayerAbilityHandler/"+subject)
		if ability_node:
			texture_rect1.self_modulate = Color.WHITE
			texture_rect2.self_modulate = Color.WHITE
			symbol_label.self_modulate = Color.WHITE
			tag = "learned"

func _on_pressed() -> void:
	if not get_node("/root/Main").game_over and accessible and ui.unlock_points >= 1:
		var ability_node = get_node_or_null("/root/Main/PlayerAbilityHandler/"+subject)
		if not ability_node:
			ui.unlock_points -= 1
			get_node("/root/Main/PlayerAbilityHandler").learn(subject, 1)
			point_counter.update()
			texture_rect1.self_modulate = Color.WHITE
			texture_rect2.self_modulate = Color.WHITE
			symbol_label.self_modulate = Color.WHITE
			tag = "Learned"
			if description_nodes.size() > 0:
				description_nodes[0].set_tag(tag)
		get_node("/root/Main").play_sound("Click")
	else:
		get_node("/root/Main").play_sound("Error")

func _on_mouse_entered() -> void:
	if accessible:
		super()
