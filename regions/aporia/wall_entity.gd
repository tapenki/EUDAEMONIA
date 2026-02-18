extends Entity

##TODO can spawn inside walls?
func random_valid_position(tilemap):
	var cell = tilemap.get_used_cells_by_id(0).pick_random()
	var offsets = {Vector2i(1, 1) : false, Vector2i(1, 0): false, Vector2i(0, 1): false, Vector2i(0, 0): false}
	for i in offsets:
		var tiles = [Vector2i(-1, -1), Vector2i(-1, 0), Vector2i(0, -1), Vector2i(0, 0)]
		for j in tiles:
			if tilemap.get_cell_source_id(cell + i + j) == 2:
				offsets[i] = true
				break
		if not offsets[i]:
			offsets.erase(i)
	return Vector2((cell + offsets.keys().pick_random()) * tilemap.tile_set.tile_size)
