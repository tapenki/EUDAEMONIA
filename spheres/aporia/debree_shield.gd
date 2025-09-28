extends Node2D

@export var ability_handler: Node

@export var entity_scene = preload("res://spheres/aporia/debree/debree.tscn")
@export var count: int
@export var health: int

func _ready() -> void:
	for repeat in count:
		var entity_instance = ability_handler.make_summon(entity_scene, 
		Vector2(),
		3,
		get_node("/root/Main").scale_enemy_health(health))
		add_child(entity_instance)
	ability_handler.self_death.connect(self_death)

func self_death():
	for debree in get_children():
		debree.loosen()
