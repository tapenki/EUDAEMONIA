extends Ability

var inheritance_level = 4

var bullet = preload("res://generic/projectiles/bullet.tscn")

var shard_blast: bool

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)
	
func entity_death(dying_entity: Entity):
	var total = 4
	if shard_blast and dying_entity.ability_handler.has_node("bomb"):
		total = 12
	elif dying_entity.summoned:
		total = 2
	
	var angle = randf_range(0, TAU)
	for repeat in total:
		var bullet_instance = ability_handler.make_projectile(bullet, 
		dying_entity.global_position, 
		3,
		Vector2.from_angle(angle + (TAU / total * repeat)) * 600)
		bullet_instance.ability_handler.inherited_damage["multiplier"] *= level
		bullet_instance.ability_handler.inherited_scale["multiplier"] *= 1.25
		get_node("/root/Main/Projectiles").add_child(bullet_instance)
