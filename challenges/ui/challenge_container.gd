extends Control

@onready var container = $Container
var reminder = preload("res://ui/misc/reminder.tscn")

func remload():
	var player = get_node("/root/Main/UI").player
	var count = 0
	for i in player.ability_handler.get_children():
		if AbilityData.ability_data.has(i.name) and (AbilityData.ability_data[i.name].type == "challenge"):
			count += 1
			var reminder_instance = reminder.instantiate()
			reminder_instance.subject = i.name
			container.add_child(reminder_instance)
	if count == 0:
		visible = false
	else:
		visible = true

func _ready() -> void:
	remload()
