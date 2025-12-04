extends Ability

func _physics_process(delta: float) -> void:
	var space_state = get_node("/root/Main").physics_space
	var shape_query = PhysicsShapeQueryParameters2D.new()
	shape_query.shape = CircleShape2D.new()
	shape_query.shape.radius = 200
	shape_query.transform = shape_query.transform.translated(global_position)
	shape_query.collision_mask = ability_handler.enemies_mask()
	shape_query.collide_with_areas = true
	shape_query.collide_with_bodies = false
	var intersections = space_state.intersect_shape(shape_query, 128)
	for i in intersections:
		var projectile = i.get("collider")
		if projectile is Projectile:
			projectile.velocity += global_position.direction_to(projectile.global_position) * 300 * delta * ability_handler.speed_scale

func inherit(handler, tier):
	if tier < 3:
		return
	super(handler, tier)
