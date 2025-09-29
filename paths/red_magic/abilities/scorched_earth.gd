extends Ability

var inheritance_level = 2

var bullet = preload("res://paths/red_magic/scorched_earth.tscn")

func _ready() -> void:
	ability_handler.self_death.connect(self_death)
	
func self_death() -> void:
	var bullet_instance = ability_handler.make_projectile(bullet, 
	global_position, 
	2,
	Vector2())
	bullet_instance.ability_handler.inherited_damage["multiplier"] *= 0.25 * level
	if ability_handler.type == "entity":
		bullet_instance.ability_handler.inherited_scale["multiplier"] *= 1.5
	get_node("/root/Main/Projectiles").add_child(bullet_instance)
