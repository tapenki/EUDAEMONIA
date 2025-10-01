extends Ability

var inheritance_level = 4

var summon = preload("res://paths/red_magic/flaming_skull/flaming_skull.tscn")

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)

func day_start(_day: int) -> void:
	var summon_positions = [
		get_node("/root/Main").layout.get_node("Positions/InnerLeft").global_position,
		get_node("/root/Main").layout.get_node("Positions/InnerTop").global_position,
		get_node("/root/Main").layout.get_node("Positions/InnerRight").global_position,
		get_node("/root/Main").layout.get_node("Positions/InnerBottom").global_position,
	]
	for i in summon_positions:
		var summon_instance = ability_handler.make_summon(summon, 
		i,
		3,  ## inheritance
		35 * level) ## health
		summon_instance.ability_handler.inherited_damage["multiplier"] *= level
		
		summon_instance.ability_handler.grant("fireburst", level)
		
		get_node("/root/Main").spawn_entity(summon_instance)
