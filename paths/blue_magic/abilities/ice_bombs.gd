extends Ability

var inheritance_level = 4
var type = "Upgrade"

var bomb = preload("res://paths/blue_magic/icebomb/icebomb.tscn")
var bomb_script = preload("res://paths/blue_magic/icebomb/bomb.gd")

var summon_positions = [
	Vector2(600, 300),
	Vector2(300, 300),
]

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)
	
func day_start(_day: int) -> void:
	for i in summon_positions:
		var summon_instance = ability_handler.make_summon(bomb, 
		i,
		3,  ## inheritance
		1, ## health
		ability_handler.get_enemy_group()) ## group
		summon_instance.ability_handler.inherited_damage["multiplier"] *= 0.25*level
		
		summon_instance.get_node("Sprite").modulate = get_node("/root/Main/Config").get_team_color(3, "secondary")
		
		summon_instance.ability_handler.grant(bomb_script, "bomb", level)
		
		get_node("/root/Main").spawn_entity(summon_instance)
