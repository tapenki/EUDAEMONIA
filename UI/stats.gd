extends Control

@onready var ability_handler = get_node("/root/Main/UI").player.ability_handler

@onready var description = get_node("/root/Main/UI/Description")
@onready var description_title = description.get_node("Title")
@onready var description_extra = description_title.get_node("Extra")

func _on_mouse_entered() -> void:
	description_title.text = "stats"
	description_extra.visible = false
	
	var attack_damage = ability_handler.inherited_damage.duplicate()
	ability_handler.damage_dealt_modifiers.emit(null, attack_damage)
	ability_handler.damage_dealt_modifiers_no_inh.emit(null, attack_damage)
	var attack_scale = ability_handler.inherited_scale.duplicate()
	ability_handler.attack_scale_modifiers.emit(attack_scale)
	var move_speed = ability_handler.get_move_speed(450)
	## yeah
	description.text = "Attack damage: [outline_size=10][+{attack_damage_source}/x{attack_damage_multiplier}][/outline_size]
Attack size: [outline_size=10][x{attack_scale}][/outline_size]
Move speed: [outline_size=10][+{move_speed}][/outline_size]".format({
"attack_damage_source": (int)(attack_damage["source"]),
"attack_damage_multiplier": attack_damage["multiplier"],
"attack_scale": (1 + attack_scale["source"]) * attack_scale["multiplier"],
"move_speed": (int)(move_speed),})
	
	description.size = Vector2(240, description.get_content_height())
	description_title.size = Vector2(240, description_title.get_content_height())
	description_title.position.y = -description_title.size.y - 4
	
	var name_offset = description_title.get_content_height() + 18
	var description_offset = description.get_content_height() + 6
	description.global_position = (global_position + Vector2(size.x - description.size.x, size.y) * 0.5).clamp(Vector2(6, name_offset), Vector2(900 - 306, 600 - description_offset))
	
	description.visible = true

func _on_mouse_exited() -> void:
	description.visible = false
