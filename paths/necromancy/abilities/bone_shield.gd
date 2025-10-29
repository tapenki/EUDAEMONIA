extends Ability

@export var summon_scene = preload("res://paths/necromancy/bone_shield/bone_shield.tscn")

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)
	get_node("/root/Main").intermission.connect(intermission)

func day_start(_day: int) -> void:
	var summon_instance = ability_handler.make_summon(summon_scene, 
	Vector2(),
	3,
	60 * level)
	summon_instance.ability_handler.inherited_damage["multiplier"] *= level
	add_child(summon_instance)

func intermission(_day: int) -> void:
	for shield in get_children():
		shield.queue_free()

func self_death():
	for shield in get_children():
		shield.kill()

func inherit(_handler, _tier):
	return
