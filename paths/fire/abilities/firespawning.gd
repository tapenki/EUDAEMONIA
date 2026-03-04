extends Ability

var summon = preload("res://paths/fire/flaming_skull/flaming_skull.tscn")

var undying_flames: bool

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)
	get_node("/root/Main").entity_death.connect(entity_death)

func spawn(spawn_position: Vector2, delay = 0.5):
	var summon_instance = ability_handler.make_summon(summon, 
	spawn_position,
	2)  ## inheritance
	summon_instance.max_health *= level
	summon_instance.health = summon_instance.max_health
	summon_instance.ability_handler.inherited_damage["multiplier"] *= 0.5 * level
	summon_instance.ability_handler.apply_ability("fireburst", level)
	get_node("/root/Main").spawn_entity(summon_instance, delay)

func day_start(_day: int) -> void:
	var tilemap = get_node("/root/Main").room_node.get_node("TileMap")
	var wall_cells = tilemap.get_used_cells_by_id(0)
	var floor_cells = tilemap.get_used_cells_by_id(2)
	for j in wall_cells:
		for k in range(-1, 2):
			for l in range(-1, 2):
				floor_cells.erase(Vector2i(j.x + k, j.y + l))
	for i in 4:
		var cell = floor_cells.pick_random()
		var spawn_position = Vector2(cell * tilemap.tile_set.tile_size) + tilemap.tile_set.tile_size * 0.5
		spawn(spawn_position)

func entity_death(dying_entity: Entity):
	if undying_flames and dying_entity.scene_file_path == "res://paths/fire/flaming_skull/flaming_skull.tscn":
		ability_handler.deal_damage(ability_handler.owner, {"base" : level, "multiplier" : 1.0, "skip_input_modifiers": true, "skip_output_modifiers": true, "skip_immunity": true}, Config.get_team_color(1, "tertiary"))
		spawn(dying_entity.global_position, 1)

func inherit(_handler, _tier):
	return
