extends Node2D

@export var entity: String

func _ready() -> void:
	get_node("/root/Main").wave_start.connect(wave_start)

func wave_start(wave):
	if wave == get_parent():
		var enemy_instance = get_node("/root/Main").instantiate_enemy(RegionData.entity_data[entity]["scene"])
		enemy_instance.position = global_position
		get_node("/root/Main").spawn_entity(enemy_instance)
