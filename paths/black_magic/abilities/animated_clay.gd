extends Ability

var inheritance_level = 4

var summon = preload("res://paths/black_magic/clay/clay.tscn")

var multimold: bool

func _ready() -> void:
	if ability_handler.has_node("multimold"):
		multimold = true
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
		4,  ## inheritance
		100 * level) ## health
		summon_instance.ability_handler.inherited_damage["multiplier"] *= 0.5 + 0.5 * level
		get_node("/root/Main").spawn_entity(summon_instance)
