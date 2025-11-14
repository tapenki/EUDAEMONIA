extends Control

@onready var container = $Container
var reminder = preload("res://equipment/ui/equipment_reminder.tscn")

var weapon_texture = preload("res://equipment/ui/weapon.png")

func remload():
	var player = get_node("/root/Main/UI").player
	for i in player.ability_handler.get_children():
		if AbilityData.ability_data.has(i.name) and (AbilityData.ability_data[i.name].type == "weapon" or AbilityData.ability_data[i.name].type == "armor"):
			var reminder_instance = reminder.instantiate()
			reminder_instance.subject = i.name
			if AbilityData.ability_data[i.name].type == "weapon":
				reminder_instance.texture_normal = weapon_texture
			container.add_child(reminder_instance)

func _ready() -> void:
	remload()
