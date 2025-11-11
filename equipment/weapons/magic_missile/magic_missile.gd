extends Ability

var bullet = preload("res://generic/projectiles/bullet.tscn")
const wait_time = 0.35
var time_left = 0

func _ready() -> void:
	ability_handler.attack.connect(attack)

func _process(delta: float) -> void:
	if time_left > 0:
		time_left -= delta * ability_handler.speed_scale

func attack(direction):
	if time_left <= 0:
		fire(direction)
		time_left = wait_time

func fire(direction):
	var bullet_instance = ability_handler.make_projectile(bullet, 
	global_position + direction * 25, 
	2,
	direction * 600)
	get_node("/root/Main/Projectiles").add_child(bullet_instance)
	get_node("/root/Main").play_sound("ShootLight")
