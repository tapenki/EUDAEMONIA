class_name Player extends Entity

@onready var bullet_timer = $BulletTimer
var bullet = preload("res://generic/projectiles/bullet.tscn")

func shoot(direction):
	var bullet_instance = ability_handler.make_projectile(bullet, 
	global_position + direction * 25, 
	3,
	direction * 600)
	get_node("/root/Main/Projectiles").add_child(bullet_instance)

func _ready() -> void:
	super()
	$Sprite.modulate = Config.get_team_color(group, "primary")

func _physics_process(_delta):
	if not alive:
		return
	if Input.is_action_pressed("fire") and not bullet_timer.running:
		## handle fire rate
		var fire_rate = ability_handler.get_attack_rate(0.35)
		bullet_timer.start(fire_rate)
		## create bullet
		var attack_direction = (get_global_mouse_position() - global_position).normalized()
		shoot(attack_direction)
		ability_handler.attack.emit(attack_direction)
		get_node("/root/Main").play_sound("ShootLight")
	var direction = Input.get_vector("left", "right", "up", "down")
	var speed = ability_handler.get_move_speed(450) * ability_handler.speed_scale
	velocity = lerp(velocity, direction * speed, 0.2)
	if direction.length() > 0:
		animation_player.play("WALK")
	else:
		animation_player.play("RESET")
	super(_delta)
