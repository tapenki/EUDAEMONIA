extends Ability

var bomb = preload("res://paths/ice/cryobomb/cryobomb.tscn")

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)
	
func day_start(_day: int) -> void:
	for i in 2:
		var tilemap = get_node("/root/Main").room_node.get_node("TileMap")
		var cell = tilemap.get_used_cells_by_id(2).pick_random()
		var spawn_position = Vector2(cell * tilemap.tile_set.tile_size) + tilemap.tile_set.tile_size * 0.5
		var summon_instance = ability_relay.make_summon(bomb, 
		spawn_position,
		2)  ## inheritance
		for layer in range(1, 3):
			summon_instance.set_collision_layer_value(layer, layer != ability_relay.owner.group)
		summon_instance.ability_relay.inherited_damage["multiplier"] *= 0.2*level
		
		summon_instance.apply_palette(ability_relay.owner.group, "tertiary")
		
		summon_instance.ability_relay.apply_ability("cryonic_volatility", level)
		
		get_node("/root/Main").spawn_entity(summon_instance)

func inherit(_handler, _tier):
	return
