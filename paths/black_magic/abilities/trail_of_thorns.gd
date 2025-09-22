extends Ability

var inheritance_level = 3
var type = "Upgrade"

var bullet = preload("res://paths/black_magic/spike.tscn")

var charge = 0

func _ready() -> void:
	ability_handler.movement.connect(movement)

func movement(distance) -> void:
	charge += distance
	if charge >= 75:
		charge -= 75
		var bullet_instance = ability_handler.make_projectile(bullet, 
		ability_handler.owner.global_position, 
		3,
		Vector2())
		bullet_instance.ability_handler.inherited_damage["multiplier"] *= level
		get_node("/root/Main/Projectiles").add_child(bullet_instance)
