extends Node2D

#var label_scene = preload("res://generic/misc/speech_label.tscn")

@export var spawn_quotes: Array
@export var death_quotes: Array

var cleanup = false

func say(text: String):
	#var label_instance = label_scene.instantiate()
	#label_instance.text = tr(text)
	#add_child(label_instance)
	var color = Config.config.get_value("palette", "2/primary", "ffffff")
	get_node("/root/Main").floating_text(global_position, "[!]", Color(color))
	var time = "["+str(Time.get_time_dict_from_system().hour)+":"+str(Time.get_time_dict_from_system().minute)+"]"
	get_node("/root/Main/UI/HUD/Chat").print_message(time+"[outline_color=#"+color+"]"+tr(text)+"[/outline_color]")

func _ready() -> void:
	if owner.group != 2:
		return
	if spawn_quotes.size() > 0:
		say(spawn_quotes.pick_random())
	var ability_handler = owner.get_node_or_null("AbilityHandler")
	if ability_handler:
		ability_handler.self_death.connect(parent_died)

func parent_died():
	if death_quotes.size() > 0:
		say(death_quotes.pick_random())
	reparent(get_tree().current_scene)
	cleanup = true

func _physics_process(_delta: float) -> void:
	if cleanup and get_children().size() == 0:
		queue_free()
