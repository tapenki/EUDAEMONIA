extends Ability

var bullet = preload("res://paths/ice/shard.tscn")

func apply(ability_relay, applicant_data):
	if ability_relay.owner.scene_file_path != "res://paths/blade/sword/slash.tscn":
		return
	applicant_data["exclude"] = []
	super(ability_relay, applicant_data)

func _physics_process(_delta: float) -> void:
	for ability_relay in applicants:
		var unsheathe = ability_handler.get_node_or_null("unsheathe")
		if not unsheathe or not unsheathe.applicants.has(ability_relay) or not unsheathe.applicants[ability_relay].has("unsheathe_multiplier") or unsheathe.applicants[ability_relay]["unsheathe_multiplier"] < 4:
			continue
		var attack_scale = ability_relay.get_attack_scale()
		var space_state = get_node("/root/Main").physics_space
		var shape_query = PhysicsShapeQueryParameters2D.new()
		shape_query.shape = CircleShape2D.new()
		shape_query.shape.radius = 40 * attack_scale
		shape_query.transform = shape_query.transform.translated(ability_relay.global_position)
		shape_query.collision_mask = ability_relay.enemies_mask()
		shape_query.collide_with_areas = true
		shape_query.collide_with_bodies = false
		var intersections = space_state.intersect_shape(shape_query, 128)
		for i in intersections:
			var projectile = i.get("collider")
			if not projectile.get("ability_relay") or not projectile.ability_relay.is_projectile:
				continue
			if applicants[ability_relay]["exclude"].has(projectile):
				continue
			applicants[ability_relay]["exclude"].append(projectile)
			var bullet_velocity = ability_relay.owner.velocity.normalized()
			var target = ability_relay.find_target(projectile.global_position, 9999)
			if target:
				bullet_velocity = projectile.global_position.direction_to(target.global_position)
			ability_relay.assign_projectile_group(projectile, ability_relay.owner.group)
			projectile.velocity = bullet_velocity * projectile.velocity.length()
			
			projectile.ability_relay.source = ability_relay
			projectile.ability_relay.entity_source = ability_relay.entity_source
			
			var scale = ability_relay.inherited_scale.duplicate()
			projectile.ability_relay.inherited_scale = scale
			
			var damage = ability_relay.inherited_damage.duplicate()
			projectile.ability_relay.inherited_damage = damage
			
			var crit_chance = ability_relay.inherited_crit_chance.duplicate()
			projectile.ability_relay.inherited_crit_chance = crit_chance
			
			if ability_handler:
				ability_handler.subscribe(projectile.ability_relay, {"subscription" = 2})
