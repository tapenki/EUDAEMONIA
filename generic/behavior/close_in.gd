extends State

@export var speed: int
@export var distance_margin: int
@export var shapecast_radius: int = 16

@export var next: State

#var node2d = Node2D.new()
#
#func _ready() -> void:
	#add_child(node2d)

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
	#for i in node2d.get_children():
		#i.queue_free()
	if not is_instance_valid(state_handler.target):
		state_handler.target = user.ability_handler.find_target()
	if not is_instance_valid(state_handler.target) or user.knockback_timer.running:
		if user.animation_player.current_animation == "WALK":
			user.animation_player.stop()
		return
	
	## shapecast to proceed to next state
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
	var direction: Vector2
	
	var path = get_node("/root/Main").pathfind(user.global_position, state_handler.target.global_position)
	
	if path.size() == 0:
		if user.animation_player.current_animation == "WALK":
			user.animation_player.stop()
		return
	
	#for i in path:
		#var rect = ColorRect.new()
		#rect.position = i
		#rect.size = Vector2(4, 4)
		#node2d.add_child(rect)
	
	direction = user.global_position.direction_to(path[0])
	
	var final_speed = user.ability_handler.get_move_speed(speed)
	user.velocity = lerp(user.velocity, direction * final_speed, 0.5)
	
	var avoid = avoidance()
	if avoid:
		var avoid_direction = avoid.global_position.direction_to(user.global_position)
		user.velocity = lerp(user.velocity, avoid_direction * final_speed, 0.075)
	user.animation_player.play("WALK")
	user.still = false
