extends Ability

var bramble = preload("res://paths/life/bramble/bramble.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("bramble_shot") and event.is_action("bramble_shot"):
		ability_handler.deal_damage(ability_handler.owner, {"base" : 25, "multiplier" : 1.0}, false, false, Config.get_team_color(1, "tertiary"))
		var direction = (get_global_mouse_position() - global_position).normalized()
		var bullet_instance = ability_handler.make_projectile(bramble, 
		global_position + direction * 25, 
		2,
		direction * 600)
		bullet_instance.ability_handler.inherited_damage["multiplier"] *= 3
		get_node("/root/Main/Projectiles").add_child(bullet_instance)
		get_node("/root/Main").play_sound("ShootLight")

func inherit(_handler, _tier):
	return
