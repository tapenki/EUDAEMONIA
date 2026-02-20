extends Ability

var summon = preload("res://paths/life/clay/clay.tscn")

var multimold: bool

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)
	
func day_start(_day: int) -> void:
	var offsets = [Vector2(0, 60)]
	if multimold:
		offsets = [Vector2(15, 60), Vector2(-15, 60)]
	var entrance_door = get_node("/root/Main").room_node.get_node("Doors/"+get_node("/root/Main").door)
	for summon_offset in offsets:
		var summon_position = entrance_door.global_position + summon_offset.rotated(entrance_door.rotation)
		var summon_instance = ability_handler.make_summon(summon, 
		summon_position, 
		3)  ## inheritance
		summon_instance.max_health *= level
		summon_instance.health = summon_instance.max_health
		summon_instance.ability_handler.inherited_damage["multiplier"] *= 0.5 + 0.5 * level
		get_node("/root/Main").spawn_entity(summon_instance)

func inherit(_handler, _tier):
	return
