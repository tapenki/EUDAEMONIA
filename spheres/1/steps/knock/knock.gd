extends Ability

var reminder_scene = preload("res://spheres/1/steps/knock/knock_trick_reminder.tscn")
var reminder_node: Node

@export var projectile_scene = preload("res://spheres/1/steps/knock/knock_explosion/knock_explosion.tscn")

func apply(ability_relay, applicant_data):
	if applicant_data.has("knock"):
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	elif applicants.has(ability_relay.source) and applicants[ability_relay.source].has("knock"):
		applicant_data["knock"] = applicants[ability_relay.source]["knock"]
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func _ready() -> void:
	reminder_node = reminder_scene.instantiate()
	get_node("/root/Main/UI/HUD/Tricks").add_child(reminder_node)
	get_node("/root/Main/UI/HUD/Tricks").move_child(reminder_node, 0)
	ability_handler.reward_recieved.connect(func(kind):
		if kind == "nous":
			level += 1
			ability_handler.abilities_changed.emit()
	)

func unlearn():
	reminder_node.queue_free()
	super()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("knock") and event.is_action("knock"):
		if level < 1:
			return
		level -= 1
		ability_handler.abilities_changed.emit()
		for ability_relay in applicants:
			if not ability_relay.is_inside_tree():
				return
			if applicants[ability_relay].has("subscription") and applicants[ability_relay]["subscription"] < 3:
				return
			var projectile_instance = ability_relay.make_projectile(projectile_scene, 
			ability_relay.global_position, 
			{"subscription" = 2, "knock" = true})
			projectile_instance.scale_multiplier = 2.5
			get_node("/root/Main/Projectiles").add_child(projectile_instance)
			get_node("/root/Main").play_sound("Explosion")

func damage_dealt_modifiers(_entity, damage) -> void:
	damage["base"] += 25
