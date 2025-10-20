extends State

@export var next: State

func on_enter() -> void:
	super()
	
	var cell = get_node("/root/Main").layout.get_node("TileMap").get_used_cells_by_id(0).pick_random()
	user.global_position = Vector2(cell * 30) + Vector2(15, 15)
	
	state_handler.change_state(next)
