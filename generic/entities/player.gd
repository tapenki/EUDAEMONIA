class_name Player extends Entity

var attacking: bool

func _ready() -> void:
	super()
	apply_palette(group, "primary")

func _physics_process(_delta):
	if not alive:
		return
	if attacking:
		var attack_direction = (get_global_mouse_position() - global_position).normalized()
		ability_handler.attack.emit(attack_direction)
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction: #and not knockback_timer.running:
		still = false
		var speed = ability_handler.get_move_speed(360)
		velocity = lerp(velocity, direction * speed, 0.2)
		animation_player.play("WALK")
	elif animation_player.current_animation == "WALK":
		animation_player.play("RESET")
	super(_delta)

func _unhandled_input(event: InputEvent) -> void:
	 ##is_action_just_pressed_by_event doesn't work with mouse buttons :(
	if Input.is_action_just_pressed("attack") and event.is_action("attack"):
		attacking = true
	if Input.is_action_just_released("attack") and event.is_action("attack"):
		attacking = false

func take_damage(source, damage, immune_affected = true):
	var took_damage = super(source, damage, immune_affected)
	if took_damage and immune_affected:
		get_node("/root/Main").screenshake.emit(0.2)
	return took_damage
