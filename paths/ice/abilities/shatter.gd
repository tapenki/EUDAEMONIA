extends Ability

var bullet = preload("res://generic/projectiles/bullet.tscn")

var shard_blast: bool

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)
	
func entity_death(dying_entity: Entity):
	var damage_mult = 0.5 * level
	var total = 3
	if shard_blast and dying_entity.scene_file_path == "res://paths/ice/cryobomb/cryobomb.tscn":
		total = 6
		damage_mult *= 2
	elif dying_entity.summoned:
		total = 1
	
	var angle = randf_range(0, TAU)
	var target = ability_handler.find_target(dying_entity.global_position, 9999, {dying_entity : true})
	if target:
		angle = dying_entity.global_position.direction_to(target.global_position).angle()
	for repeat in total:
		var bullet_instance = ability_handler.make_projectile(bullet, 
		dying_entity.global_position, 
		2,
		Vector2.from_angle(angle + (TAU / total * repeat)) * 600)
		bullet_instance.exclude[dying_entity] = INF
		bullet_instance.ability_handler.inherited_damage["multiplier"] *= damage_mult
		bullet_instance.ability_handler.inherited_scale["multiplier"] *= 1.2
		get_node("/root/Main/Projectiles").add_child(bullet_instance)
	if shard_blast and dying_entity.scene_file_path == "res://paths/ice/cryobomb/cryobomb.tscn":
		for repeat in total:
			var bullet_instance = ability_handler.make_projectile(bullet, 
			dying_entity.global_position, 
			2,
			Vector2.from_angle(angle + PI / total + (TAU / total * repeat)) * 450)
			bullet_instance.exclude[dying_entity] = INF
			bullet_instance.ability_handler.inherited_damage["multiplier"] *= damage_mult
			bullet_instance.ability_handler.inherited_scale["multiplier"] *= 1.2
			get_node("/root/Main/Projectiles").add_child(bullet_instance)

func inherit(_handler, _tier):
	return
