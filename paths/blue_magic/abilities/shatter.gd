extends Ability

var inheritance_level = 4

var bullet = preload("res://generic/projectiles/bullet.tscn")

var shard_blast: bool

func _ready() -> void:
	if ability_handler.has_node("shard_blast"):
		shard_blast = true
	get_node("/root/Main").entity_death.connect(entity_death)
	
func entity_death(dying_entity: Entity):
	var total = 3
	if shard_blast and dying_entity.scene_file_path == "res://paths/blue_magic/cryobomb/cryobomb.tscn":
		total = 6
	elif dying_entity.summoned:
		total = 1
	
	var angle = randf_range(0, TAU)
	var target = ability_handler.find_target(dying_entity.global_position, 9999, {dying_entity = true})
	if target:
		angle = dying_entity.global_position.direction_to(target.global_position).angle()
	for repeat in total:
		var bullet_instance = ability_handler.make_projectile(bullet, 
		dying_entity.global_position, 
		3,
		Vector2.from_angle(angle + (TAU / total * repeat)) * 600)
		bullet_instance.ability_handler.inherited_damage["multiplier"] *= level
		bullet_instance.ability_handler.inherited_scale["multiplier"] *= 1.2
		get_node("/root/Main/Projectiles").add_child(bullet_instance)
	if shard_blast and dying_entity.scene_file_path == "res://paths/blue_magic/cryobomb/cryobomb.tscn":
		for repeat in total:
			var bullet_instance = ability_handler.make_projectile(bullet, 
			dying_entity.global_position, 
			3,
			Vector2.from_angle(angle + PI / total + (TAU / total * repeat)) * 450)
			bullet_instance.ability_handler.inherited_damage["multiplier"] *= level
			bullet_instance.ability_handler.inherited_scale["multiplier"] *= 1.2
			get_node("/root/Main/Projectiles").add_child(bullet_instance)
