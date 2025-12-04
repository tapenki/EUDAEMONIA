extends Ability

@export var summon_scene = preload("res://paths/death/bone_shield/bone_shield.tscn")

var bone_spear: bool

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)
	get_node("/root/Main").intermission.connect(intermission)

func day_start(_day: int) -> void:
	var count = 1
	if bone_spear:
		count = 4
	for i in count:
		var summon_instance = ability_handler.make_summon(summon_scene, 
		Vector2(),
		2,
		60 * level)
		summon_instance.distance = 50*(i+1)
		summon_instance.scale *= 1 + (count - i) * 0.2
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
