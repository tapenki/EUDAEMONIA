extends Ability

var bullet = preload("res://equipment/weapons/star_blaze/star_bomb.tscn")
const wait_time = 0.8
const bullet_speed = 600
var time_left = 0

func _ready() -> void:
	ability_relay.attack.connect(attack)

func _process(delta: float) -> void:
	if time_left > 0:
		time_left -= delta * ability_relay.speed_scale

func attack(direction):
	if time_left <= 0:
		fire(direction)
		time_left = wait_time

func fire(direction):
	var bullet_instance = ability_relay.make_projectile(bullet, 
	global_position + direction * 25, 
	2,
	direction * bullet_speed)
	get_node("/root/Main/Projectiles").add_child(bullet_instance)
	get_node("/root/Main").play_sound("ShootLight")
