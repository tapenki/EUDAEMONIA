extends Ability

var inheritance_level = 3
var type = "Upgrade"

var bullet = preload("res://generic/projectiles/bullet.tscn")

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)
	
func entity_death(dying_entity: Entity):
	var total = 4
	var angle = randf_range(0, TAU)
	for repeat in total:
		var bullet_instance = ability_handler.make_projectile(bullet, 
		dying_entity.global_position, 
		3,
		Vector2.from_angle(angle + (TAU / total * repeat)) * 600,
		{"source" : 0, "multiplier" : level})
		get_node("/root/Main/Projectiles").add_child(bullet_instance)
