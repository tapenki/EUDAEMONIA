class_name Player extends Entity

func _ready() -> void:
	super()
	$Sprite.modulate = Config.get_team_color(group, "primary")

func _physics_process(_delta):
	if not alive:
		return
	if Input.is_action_pressed("attack"):
		var attack_direction = (get_global_mouse_position() - global_position).normalized()
		ability_handler.attack.emit(attack_direction)
	var direction = Input.get_vector("left", "right", "up", "down")
	var speed = ability_handler.get_move_speed(450) * ability_handler.speed_scale
	velocity = lerp(velocity, direction * speed, 0.2)
	if direction.length() > 0:
		animation_player.play("WALK")
	else:
		animation_player.play("RESET")
	super(_delta)

func take_damage(source, damage, immune_affected = true):
	var took_damage = super(source, damage, immune_affected)
	if took_damage and immune_affected:
		get_node("/root/Main").screenshake.emit(0.2)
	return took_damage
