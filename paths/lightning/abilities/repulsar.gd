extends Ability

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 3:
		return
	super(ability_relay, applicant_data)

func _physics_process(delta: float) -> void:
	for ability_relay in applicants:
		var space_state = get_node("/root/Main").physics_space
		var shape_query = PhysicsShapeQueryParameters2D.new()
		shape_query.shape = CircleShape2D.new()
		shape_query.shape.radius = 200
		shape_query.transform = shape_query.transform.translated(ability_relay.global_position)
		shape_query.collision_mask = ability_relay.enemies_mask()
		shape_query.collide_with_areas = true
		shape_query.collide_with_bodies = false
		var intersections = space_state.intersect_shape(shape_query, 128)
		for i in intersections:
			var projectile = i.get("collider")
			if projectile is Projectile:
				projectile.velocity += ability_relay.global_position.direction_to(projectile.global_position) * 200 * delta * ability_relay.speed_scale
