extends Ability

var bullet = preload("res://equipment/weapons/trick_bullets/bouncing_bullet.tscn")
const bullet_count = 2
const spread = 45
const wait_time = 0.5
const bullet_speed = 600
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
	var stepsize = deg_to_rad(spread) / (bullet_count - 1)
	var halfspan = deg_to_rad(spread) * 0.5
	for i in bullet_count:
		var bullet_instance = ability_handler.make_projectile(bullet, 
		global_position + direction * 25, 
		2,
		direction.rotated(halfspan - (stepsize * i)) * bullet_speed)
		get_node("/root/Main/Projectiles").add_child(bullet_instance)
	
	get_node("/root/Main").play_sound("ShootLight")
