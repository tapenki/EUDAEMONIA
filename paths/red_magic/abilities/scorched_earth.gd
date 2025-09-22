extends Ability

var inheritance_level = 2
var type = "Upgrade"

var bullet = preload("res://paths/red_magic/scorched_earth.tscn")

func _ready() -> void:
	ability_handler.attack_impact.connect(attack_impact)
	
func attack_impact(impact_position, _body) -> void:
	var bullet_instance = ability_handler.make_projectile(bullet, 
	impact_position, 
	2,
	Vector2())
	bullet_instance.ability_handler.inherited_damage["multiplier"] *= 0.25 * level
	get_node("/root/Main/Projectiles").add_child(bullet_instance)
