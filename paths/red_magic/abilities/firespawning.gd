extends Ability

var inheritance_level = 4

var summon = preload("res://paths/red_magic/flaming_skull/flaming_skull.tscn")

var summon_positions = [
	Vector2(600, 300),
	Vector2(300, 300),
	Vector2(450, 450),
	Vector2(450, 150)
]

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)

func day_start(_day: int) -> void:
	for i in summon_positions:
		var summon_instance = ability_handler.make_summon(summon, 
		i,
		3,  ## inheritance
		35 * level) ## health
		summon_instance.ability_handler.inherited_damage["multiplier"] *= level
		
		summon_instance.ability_handler.grant("fireburst", level)
		
		get_node("/root/Main").spawn_entity(summon_instance)
