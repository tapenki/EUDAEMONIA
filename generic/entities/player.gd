class_name Player extends Entity

@onready var bullet_timer = $BulletTimer
var bullet = preload("res://generic/projectiles/bullet.tscn")

var attack: bool

func shoot(direction):
	var bullet_instance = ability_handler.make_projectile(bullet, 
	global_position + direction * 25, 
	2,
	direction * 600)
	get_node("/root/Main/Projectiles").add_child(bullet_instance)

func _ready() -> void:
	super()
	$Sprite.modulate = Config.get_team_color(group, "primary")

func _physics_process(_delta):
	if not alive:
		return
	if attack and not bullet_timer.running:
		## handle fire rate or maybe don't
		#var fire_rate = ability_handler.get_attack_rate(0.35)
		bullet_timer.start(0.35)
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

func _unhandled_input(event: InputEvent) -> void: ## doesn't work with inputmap ??
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			attack = true
		else:
			attack = false

func take_damage(source, damage, immune_affected = true):
	var took_damage = super(source, damage, immune_affected)
	if took_damage and immune_affected:
		get_node("/root/Main").screenshake.emit(0.2)
	return took_damage
