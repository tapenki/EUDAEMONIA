extends Ability

var reminder_scene = preload("res://paths/time/time_stop_reminder.tscn")
var reminder_node: Node

var freeze: Node
var doom: Node

var no_future: bool

var active = true

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 5:
			return
	super(ability_relay, applicant_data)

func _ready() -> void:
	freeze = ability_handler.learn("freeze", 0)
	doom = ability_handler.learn("doom", 0)
	reminder_node = reminder_scene.instantiate()
	get_node("/root/Main/UI/HUD/Tricks").add_child(reminder_node)
	get_node("/root/Main/UI/HUD/Tricks").move_child(reminder_node, 0)
	get_node("/root/Main").intermission.connect(intermission)

func intermission(_day: int) -> void:
	active = true

func unlearn():
	reminder_node.queue_free()
	super()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("time_stop") and event.is_action("time_stop"):
		if active:
			active = false
			for ability_relay in applicants:
				get_node("/root/Main/ParticleHandler").quick_particles("burst", 
				preload("res://paths/statuses/chill/snow.png"),
				ability_relay.global_position,
				2,
				16,
				Config.get_team_color(ability_relay.owner.group, "secondary"))
				var space_state = get_node("/root/Main").physics_space
				var shape_query = PhysicsShapeQueryParameters2D.new()
				shape_query.shape = CircleShape2D.new()
				shape_query.shape.radius = 9999
				shape_query.transform = shape_query.transform.translated(ability_relay.global_position)
				shape_query.collision_mask = ability_relay.enemies_mask()
				shape_query.collide_with_areas = true
				var intersections = space_state.intersect_shape(shape_query, 128)
				for i in intersections:
					var collider = i.get("collider")
					if collider.get("ability_relay") and (collider.ability_relay.is_entity > 0 or collider.ability_relay.is_projectile > 0):
						freeze.apply(collider.ability_relay, {"duration" = pow(level, 0.7)})
						if no_future and collider.ability_relay.is_entity > 0:
							doom.apply(collider.ability_relay, {"stacks" = 6 * level})
			get_node("/root/Main").play_sound("Explosion")
		else:
			get_node("/root/Main").play_sound("Error")
