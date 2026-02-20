extends Ability

var soul_preservation: bool
var preserved_elite: String

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)
	get_node("/root/Main").day_start.connect(day_start)

func entity_death(dying_entity: Entity):
	if dying_entity.group == ability_handler.get_enemy_group() and not dying_entity.summoned:
		var summon_instance = ability_handler.make_summon(load(dying_entity.scene_file_path), 
		dying_entity.global_position,
		2)  ## inheritance
		if summon_instance.max_health > 100:
			preserved_elite = dying_entity.scene_file_path
		summon_instance.max_health *= 0.5 + 0.5 * level
		summon_instance.health = summon_instance.max_health
		summon_instance.ability_handler.inherited_damage["multiplier"] *= 0.5 + 0.5 * level
		get_node("/root/Main").spawn_entity(summon_instance)

func day_start(_day: int) -> void:
	if soul_preservation and preserved_elite:
		var summon_instance = ability_handler.make_summon(load(preserved_elite), 
		global_position,
		2)  ## inheritance
		summon_instance.global_position = summon_instance.random_valid_position(get_node("/root/Main").room_node.get_node("TileMap"))
		summon_instance.max_health *= 0.5 + 0.5 * level
		summon_instance.health = summon_instance.max_health
		summon_instance.ability_handler.inherited_damage["multiplier"] *= 0.5 + 0.5 * level
		get_node("/root/Main").spawn_entity(summon_instance)

func inherit(_handler, _tier):
	return

func serialize():
	return {"level" : level, "preserved_elite" : preserved_elite}

func deserialize(data):
	level = data["level"]
	preserved_elite = data["preserved_elite"]
