extends Ability

var inheritance_level = 4
var type = "Upgrade"

var summon = preload("res://paths/black_magic/clay/clay.tscn")

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)
	
func day_start(_day: int) -> void:
	var summon_instance = ability_handler.make_summon(summon, 
	Vector2(450, 300), 
	4,  ## inheritance
	ability_handler.owner.max_health + ability_handler.owner.max_health * 0.5 * level, ## health
	{"source" : 0, "multiplier" : level}) ## self explanatory
	
	get_node("/root/Main").spawn_entity(summon_instance)
