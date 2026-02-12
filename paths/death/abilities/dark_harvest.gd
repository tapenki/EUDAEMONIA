extends Ability

var explosion_scene = preload("res://paths/death/harvest_explosion.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("dark_harvest") and event.is_action("dark_harvest"):
		var target
		var to_target = INF
		for entity in ability_handler.area_targets(get_global_mouse_position(), 9999, pow(2, ability_handler.owner.group-1)):
			if entity.summoned:
				var to_entity = get_global_mouse_position().distance_to(entity.global_position)
				if to_entity < to_target:
					target = entity
					to_target = to_entity
		if target:
			var explosion_instance = ability_handler.make_projectile(explosion_scene, 
			target.global_position, ## position
			2, ## inheritance
			Vector2()) ## velocity
			explosion_instance.ability_handler.inherited_damage["base"] += target.ability_handler.get_health().max_health * 0.2
			explosion_instance.ability_handler.inherited_damage["multiplier"] *= level
			explosion_instance.scale_multiplier = 4
			get_node("/root/Main/Projectiles").add_child(explosion_instance)
			get_node("/root/Main").play_sound("Explosion")
			target.kill()

func inherit(_handler, _tier):
	return
