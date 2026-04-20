extends Ability

var reminder_scene = preload("res://paths/blade/soul_cleave_reminder.tscn")
var reminder_node: Node

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 5:
			return
	super(ability_relay, applicant_data)


func _ready() -> void:
	reminder_node = reminder_scene.instantiate()
	get_node("/root/Main/UI/HUD/Tricks").add_child(reminder_node)
	get_node("/root/Main/UI/HUD/Tricks").move_child(reminder_node, 0)

func unlearn():
	reminder_node.queue_free()
	super()

func _unhandled_input(event: InputEvent) -> void:
	for ability_relay in applicants:
		if Input.is_action_just_pressed("soul_cleave") and event.is_action("soul_cleave"):
			var target
			var to_target = INF
			for entity in ability_relay.area_targets(ability_relay.get_global_mouse_position()):
				if not entity.summoned:
					var to_entity = ability_relay.get_global_mouse_position().distance_to(entity.global_position)
					if to_entity < to_target:
						target = entity
						to_target = to_entity
			if target:
				for i in 2:
					var summon_position = target.nearby_valid_position(get_node("/root/Main").room_node.get_node("TileMap"), target.global_position, 60)
					var summon_instance = target.ability_relay.make_summon(load(target.scene_file_path), 
					summon_position,
					{"subscription" = 3})
					summon_instance.max_health = target.max_health * 0.75
					summon_instance.health = target.health * 0.75
					get_node("/root/Main").spawn_entity(summon_instance)
				target.kill()
