extends Ability

@export var summon_scene = preload("res://paths/death/bone_shield/bone_shield.tscn")

var osteophalanx: bool

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)
	get_node("/root/Main").intermission.connect(intermission)

func day_start(_day: int) -> void:
	if osteophalanx:
		var summon_instance1 = ability_handler.make_summon(summon_scene, 
		Vector2(),
		2)
		summon_instance1.max_health *= level
		summon_instance1.health = summon_instance1.max_health
		summon_instance1.distance = 75
		summon_instance1.ability_handler.inherited_damage["multiplier"] *= level
		add_child(summon_instance1)
		var summon_instance2 = ability_handler.make_summon(summon_scene, 
		Vector2(),
		2)
		summon_instance2.max_health *= level
		summon_instance2.health = summon_instance2.max_health
		summon_instance2.distance = 50
		summon_instance2.angle = PI * 0.25
		summon_instance2.ability_handler.inherited_damage["multiplier"] *= level
		add_child(summon_instance2)
		var summon_instance3 = ability_handler.make_summon(summon_scene, 
		Vector2(),
		2)
		summon_instance3.max_health *= level
		summon_instance3.health = summon_instance3.max_health
		summon_instance3.distance = 50
		summon_instance3.angle = -PI * 0.25
		summon_instance3.ability_handler.inherited_damage["multiplier"] *= level
		add_child(summon_instance3)
		var summon_instance4 = ability_handler.make_summon(summon_scene, 
		Vector2(),
		2)
		summon_instance4.max_health *= level
		summon_instance4.health = summon_instance4.max_health
		summon_instance4.distance = 50
		summon_instance4.scale *= 1.5
		summon_instance4.ability_handler.inherited_damage["multiplier"] *= level
		add_child(summon_instance4)
	else:
		var summon_instance = ability_handler.make_summon(summon_scene, 
		Vector2(),
		2)
		summon_instance.max_health *= level
		summon_instance.health = summon_instance.max_health
		summon_instance.distance = 50
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
