extends Node

@onready var timer = $Timer

@onready var tilemap = $"../TileMap"
@onready var wall_cells = tilemap.get_used_cells_by_id(0)
@onready var floor_cells = tilemap.get_used_cells_by_id(2)

var projectile_scene = preload("res://regions/olethros/bomb_reticle.tscn")

func _ready() -> void:
	for j in wall_cells:
		for k in range(-1, 2):
			for l in range(-1, 2):
				floor_cells.erase(Vector2i(j.x + k, j.y + l))

func _on_timer_timeout() -> void:
	var projectile_instance = projectile_scene.instantiate()
	get_node("/root/Main").assign_projectile_group(projectile_instance, 2, "secondary")
	var cell = floor_cells.pick_random()
	projectile_instance.position =  Vector2(cell * tilemap.tile_set.tile_size) + tilemap.tile_set.tile_size * 0.5
	projectile_instance.ability_handler.inherited_damage["multiplier"] = get_node("/root/Main").scale_enemy_damage()
	add_child(projectile_instance)
