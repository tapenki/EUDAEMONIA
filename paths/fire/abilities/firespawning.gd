extends Ability

var summon = preload("res://paths/fire/flaming_skull/flaming_skull.tscn")

var undying_flames: bool

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)
	get_node("/root/Main").entity_death.connect(entity_death)

func spawn(spawn_position: Vector2, delay = 0.5):
	var summon_instance = ability_handler.make_summon(summon, 
	spawn_position,
	2,  ## inheritance
	35 * level) ## health
	summon_instance.ability_handler.inherited_damage["multiplier"] *= level
	summon_instance.ability_handler.grant("fireburst", level)
	get_node("/root/Main").spawn_entity(summon_instance, delay)

func day_start(_day: int) -> void:
	for i in 4:
		var tilemap = get_node("/root/Main").room_node.get_node("TileMap")
		var cell = tilemap.get_used_cells_by_id(2).pick_random()
		var spawn_position = Vector2(cell * tilemap.tile_set.tile_size) + tilemap.tile_set.tile_size * 0.5
		spawn(spawn_position)

func entity_death(dying_entity: Entity):
	if undying_flames and dying_entity.scene_file_path == "res://paths/fire/flaming_skull/flaming_skull.tscn":
		spawn(dying_entity.global_position, 1)

func inherit(_handler, _tier):
	return
