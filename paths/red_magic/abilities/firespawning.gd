extends Ability

var inheritance_level = 4
var type = "Upgrade"

var summon = preload("res://paths/red_magic/flaming_skull/flaming_skull.tscn")
var burn_script = preload("res://generic/abilities/status/burn.gd")

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
		ability_handler.owner.max_health * 0.75 + 25 * level) ## health
		summon_instance.ability_handler.inherited_damage["multiplier"] *= level
		
		var burn = summon_instance.ability_handler.grant(burn_script, "burn", 10 * level)
		burn.damage_multiplier = 0
		burn.total_ticks = -1
		burn.ticks_left = -1
		
		get_node("/root/Main").spawn_entity(summon_instance)
