extends Ability

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)

func entity_death(dying_entity: Entity):
	if dying_entity.group == ability_handler.get_enemy_group() and not dying_entity.summoned:
		var summon_instance = ability_handler.make_summon(load(dying_entity.scene_file_path), 
		dying_entity.global_position,
		2,  ## inheritance
		-1) ## health
		summon_instance.max_health *= 0.4 + 0.4 * level
		summon_instance.health = summon_instance.max_health
		summon_instance.ability_handler.inherited_damage["multiplier"] *= 0.4 + 0.4 * level
		get_node("/root/Main").spawn_entity(summon_instance)

func inherit(_handler, _tier):
	return
