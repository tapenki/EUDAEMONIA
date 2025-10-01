extends Ability

var inheritance_level = 4

var summon = preload("res://paths/black_magic/clay/clay.tscn")

var multimold: bool

func _ready() -> void:
	if ability_handler.has_node("multimold"):
		multimold = true
	get_node("/root/Main").day_start.connect(day_start)
	
func day_start(_day: int) -> void:
	var positions = [global_position + Vector2(0, 50)]
	if multimold:
		positions = [global_position + Vector2(50, 0), global_position - Vector2(50, 0)]
	for summon_position in positions:
		var summon_instance = ability_handler.make_summon(summon, 
		summon_position, 
		4,  ## inheritance
		100 * level) ## health
		summon_instance.ability_handler.inherited_damage["multiplier"] *= 0.5 + 0.5 * level
		get_node("/root/Main").spawn_entity(summon_instance)
