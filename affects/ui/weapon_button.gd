extends Described

@onready var texture_rect1: = $"TextureRect1"
@onready var texture_rect2: = $"TextureRect2"
@onready var symbol_label: = $"Symbol"

#var accessible: bool

var selected: bool

func _ready() -> void:
	symbol_label.text = subject.substr(0, 2).capitalize()
	#accessible = true
	get_node("/root/Main/PlayerAbilityHandler").weapons_changed.connect(weapons_changed)
	weapons_changed()

#func _on_mouse_entered() -> void:
	#if not accessible:
		#return
	#super()

func _on_pressed() -> void:
	#if not accessible:
		#get_node("/root/Main").play_sound("Error")
		#return
	get_node("/root/Main").play_sound("Click")
	if selected:
		get_node("/root/Main/PlayerAbilityHandler").unequip_weapon(subject)
	else:
		get_node("/root/Main/PlayerAbilityHandler").equip_weapon(subject)
	if description_nodes.size() > 0:
		description_nodes[0].set_tag(tag)

func weapons_changed():
	selected = get_node("/root/Main/PlayerAbilityHandler").equipped_weapons.has(subject)
	if selected:
		texture_rect1.self_modulate = Color.WHITE
		texture_rect2.self_modulate = Color.WHITE
		symbol_label.self_modulate = Color.WHITE
		tag = "selected"
	else:
		texture_rect1.self_modulate = Color("7f7f7f")
		texture_rect2.self_modulate = Color("7f7f7f")
		symbol_label.self_modulate = Color("7f7f7f")
		tag = ""
