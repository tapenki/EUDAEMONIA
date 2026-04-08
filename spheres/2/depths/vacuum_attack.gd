extends State

@onready var timer = $"Timer"

@export var bullet: PackedScene
@export var shoot_delay = 0.25
@export var bullet_count = 4

@export var distance = 500

@export var next: State

var bullet_counter: float

func on_enter() -> void:
	super()
	timer.start()

func _physics_process(delta):
	bullet_counter += delta * user.ability_relay.speed_scale
	if bullet_counter >= shoot_delay:
		bullet_counter -= shoot_delay
		for i in bullet_count:
			var bullet_instance = user.ability_relay.make_projectile(bullet, 
			user.global_position + Vector2.UP.rotated(randf() * TAU) * distance, 
			{"subscription" = 2})
			bullet_instance.target = user
			get_node("/root/Main/Projectiles").add_child(bullet_instance)
			if bullet_instance.hit_particles:
				get_node("/root/Main").spawn_particles(get_node("/root/Main/Particles/" + bullet_instance.hit_particles), 
					4, 
					bullet_instance.global_position, 
					bullet_instance.scale.x, 
					bullet_instance.get_node("Sprite").self_modulate)
		get_node("/root/Main").play_sound("ShootLight")

func _on_timer_timeout() -> void:
	#user.ability_relay.attack.emit(direction)
	state_handler.change_state(next)

func on_exit() -> void:
	bullet_counter = 0
	super()
