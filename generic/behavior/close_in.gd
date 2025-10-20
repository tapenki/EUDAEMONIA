extends State

@export var speed: int
@export var distance_margin: int
@export var shapecast_radius: int = 16

@export var next: State

func avoidance():
	var reach = 3000
	var found
	for entity in get_node("/root/Main/Entities").get_children():
		if entity != user and not user.ability_handler.can_hit(entity):
			var distance = user.global_position.distance_to(entity.global_position)
			if distance < reach:
				reach = distance
				found = entity
	return found

func _physics_process(_delta):
	if not is_instance_valid(state_handler.target):
		state_handler.target = user.ability_handler.find_target()
	if not is_instance_valid(state_handler.target):
		user.velocity = lerp(user.velocity, Vector2(), 0.5)
		return
	
	## proceed to next state
	var distance = user.global_position.distance_to(state_handler.target.global_position)
	if distance < distance_margin:
		var perpendicular = user.global_position.direction_to(state_handler.target.global_position).rotated(PI/2)
		var cloud = PackedVector2Array([
			user.global_position + perpendicular * shapecast_radius,
			user.global_position - perpendicular * shapecast_radius,
			state_handler.target.global_position + perpendicular * shapecast_radius,
			state_handler.target.global_position - perpendicular * shapecast_radius,
		])
		var shape_query = PhysicsShapeQueryParameters2D.new()
		shape_query.shape = ConvexPolygonShape2D.new()
		shape_query.shape.set_point_cloud(cloud)
		shape_query.collision_mask = 128
		var intersections = get_node("/root/Main").physics_space.intersect_shape(shape_query, 1)
		if not intersections:
			state_handler.change_state(next)
			return
	
	## follow path
	var tilemap = get_node("/root/Main").room_node.get_node("TileMap")
	var start = tilemap.local_to_map(state_handler.target.global_position)
	var end = tilemap.local_to_map(user.global_position)
	var path = get_node("/root/Main").astar.get_point_path(start, end)
	
	if path.size() < 2:
		user.velocity = lerp(user.velocity, Vector2(), 0.5)
		return
	
	var next_position
	for i in path:
		var ray_query = PhysicsRayQueryParameters2D.create(user.global_position, i)
		ray_query.collision_mask = 128
		var intersection = get_node("/root/Main").physics_space.intersect_ray(ray_query)
		if not intersection:
			next_position = i
			break
	if not next_position:
		return
	
	var direction = user.global_position.direction_to(next_position)
	var final_speed = user.ability_handler.get_move_speed(speed) * user.ability_handler.speed_scale
	user.velocity = lerp(user.velocity, direction * final_speed, 0.5)
	
	var avoid = avoidance()
	if avoid:
		var avoid_direction = avoid.global_position.direction_to(user.global_position)
		user.velocity = lerp(user.velocity, avoid_direction * final_speed, 0.075)
	user.animation_player.play("WALK")
