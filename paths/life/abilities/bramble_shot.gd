extends Ability

var bramble = preload("res://paths/life/bramble/bramble.tscn")

func apply(ability_relay, applicant_data):
	if ability_relay.owner.scene_file_path == "res://paths/life/bramble/bramble.tscn" or (applicants.has(ability_relay.source) and applicants[ability_relay.source].has("bramble_power")):
		applicant_data["bramble_power"] = true
		ability_relay.damage_dealt_modifiers.connect(damage_dealt_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.damage_dealt_modifiers.is_connected(damage_dealt_modifiers):
		ability_relay.damage_dealt_modifiers.disconnect(damage_dealt_modifiers)

func _unhandled_input(event: InputEvent) -> void:
	for ability_relay in applicants:
		if not ability_relay.is_inside_tree():
			return
		if applicants[ability_relay].has("subscription") and applicants[ability_relay]["subscription"] < 3:
			return
		if Input.is_action_just_pressed("bramble_shot") and event.is_action("bramble_shot"):
			ability_relay.deal_damage(ability_relay.owner, {"base" : get_node("/root/Main").day + 10, "multiplier" : 1.0, "skip_input_modifiers": true, "skip_output_modifiers": true, "skip_immunity": true}, Config.get_team_color(1, "tertiary"))
			var direction = (ability_relay.get_global_mouse_position() - ability_relay.global_position).normalized()
			var bullet_instance = ability_relay.make_projectile(bramble, 
			ability_relay.global_position + direction * 25, 
			{"subscription" = 2},
			direction * 600)
			get_node("/root/Main/Projectiles").add_child(bullet_instance)
			get_node("/root/Main").play_sound("ShootLight")

func damage_dealt_modifiers(_entity, damage) -> void:
	damage["multiplier"] *= 3
