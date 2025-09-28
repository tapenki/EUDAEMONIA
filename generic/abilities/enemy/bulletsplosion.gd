extends Ability

var inheritance_level = 3
var type = "Special"

var bullet = preload("res://generic/projectiles/bullet.tscn")

func _ready() -> void:
	ability_handler.self_death.connect(self_death)

func self_death() -> void:
	var bullet_count = 2 + level
	var direction = ability_handler.owner.velocity.normalized() * -1
	var stepsize = deg_to_rad(60) / (bullet_count - 1)
	var halfspan = deg_to_rad(60) * 0.5
	for i in bullet_count:
		var bullet_instance = ability_handler.make_projectile(bullet, 
		global_position + direction * 25, 
		3,
		direction.rotated(halfspan - (stepsize * i)) * 450)
		get_node("/root/Main/Projectiles").add_child(bullet_instance)
