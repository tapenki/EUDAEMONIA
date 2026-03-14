extends Node

@export var reward: PackedScene
@export var quantity = 1

func _ready() -> void:
	get_node("/root/Main").day_cleared.connect(award.unbind(1))

func award():
	for entity in get_node("/root/Main/Entities").get_children():
		if entity is Player:
			for i in range(quantity):
				var reward_instance = reward.instantiate()
				reward_instance.position = entity.global_position + Vector2(randf_range(-100, 100), randf_range(-100, 100))
				add_sibling(reward_instance)
