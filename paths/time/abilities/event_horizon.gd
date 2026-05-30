extends Ability

var status: Node

var sink_the_time: bool

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 3:
		return
	super(ability_relay, applicant_data)

func _ready() -> void:
	status = ability_handler.learn("chill", 0)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		var space_state = get_node("/root/Main").physics_space
		var shape_query = PhysicsShapeQueryParameters2D.new()
		shape_query.shape = CircleShape2D.new()
		shape_query.shape.radius = (25 + 25 * level) * ability_relay.get_effect_scale()
		shape_query.transform = shape_query.transform.translated(ability_relay.global_position)
		shape_query.collision_mask = ability_relay.enemies_mask()
		shape_query.collide_with_areas = true
		shape_query.collide_with_bodies = false
		var intersections = space_state.intersect_shape(shape_query, 128)
		for i in intersections:
			var projectile = i.get("collider")
			if projectile.get("ability_relay") and projectile.ability_relay.is_projectile > 0:
				status.apply(projectile.ability_relay, {"duration" = 0.5 * ability_relay.get_effect_duration()})
				if sink_the_time:
					var lifetime = projectile.get_node_or_null("Lifetime")
					if lifetime and lifetime.running:
						lifetime.time_left -= delta * projectile.ability_relay.speed_scale * 2
