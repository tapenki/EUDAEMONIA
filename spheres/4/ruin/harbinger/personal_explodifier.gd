extends Node

@onready var timer = $Timer

@onready var tilemap = get_node("/root/Main").get_tilemap()
@onready var wall_cells = tilemap.get_used_cells_by_id(0)
@onready var floor_cells = tilemap.get_used_cells_by_id(2)

@export var ability_relay: Node

var projectile_scene = preload("res://spheres/4/ruin/bomb_reticle.tscn")

func _ready() -> void:
	for j in wall_cells:
		for k in range(-1, 2):
			for l in range(-1, 2):
				floor_cells.erase(Vector2i(j.x + k, j.y + l))

func _on_timer_timeout() -> void:
	if not ability_relay.owner.alive: return
	var projectile_instance = ability_relay.make_projectile(projectile_scene, 
	ability_relay.global_position, 
	{"subscription" = 2})
	var cell = floor_cells.pick_random()
	projectile_instance.position =  Vector2(cell * tilemap.tile_set.tile_size) + tilemap.tile_set.tile_size * 0.5
	get_node("/root/Main/Projectiles").add_child(projectile_instance)
