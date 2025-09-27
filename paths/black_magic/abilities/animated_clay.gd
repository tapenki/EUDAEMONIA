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
	var health_multiplier = 1
	var positions = summon_positions
	if multimold:
		health_multiplier = 0.5
		positions = multimold_positions
	for summon_position in positions:
		var summon_instance = ability_handler.make_summon(summon, 
		summon_position, 
		4,  ## inheritance
		100 * level * health_multiplier) ## health
		summon_instance.ability_handler.inherited_damage["multiplier"] *= level
		get_node("/root/Main").spawn_entity(summon_instance)
