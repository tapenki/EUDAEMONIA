extends Ability

var inheritance_level = 4

var summon = preload("res://paths/black_magic/clay/clay.tscn")

var multimold: bool

var summon_positions = [
	Vector2(450, 300),
]

var multimold_positions = [
	Vector2(500, 300),
	Vector2(400, 300)
]

func _ready() -> void:
	if ability_handler.has_node("multimold"):
		multimold = true
	get_node("/root/Main").day_start.connect(day_start)
	
func day_start(_day: int) -> void:
	var positions = summon_positions
	if multimold:
		positions = multimold_positions
	for summon_position in positions:
		var summon_instance = ability_handler.make_summon(summon, 
		summon_position, 
		4,  ## inheritance
		100 * level) ## health
		summon_instance.ability_handler.inherited_damage["multiplier"] *= 0.5 + 0.5 * level
		get_node("/root/Main").spawn_entity(summon_instance)
