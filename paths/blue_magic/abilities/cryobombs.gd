extends Ability

var inheritance_level = 4

var bomb = preload("res://paths/blue_magic/cryobomb/cryobomb.tscn")

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)
	
func day_start(_day: int) -> void:
	for i in 2:
		var spawn_position = NavigationServer2D.map_get_random_point(get_viewport().world_2d.navigation_map, 1, false)
		var summon_instance = ability_handler.make_summon(bomb, 
		spawn_position,
		3,  ## inheritance
		0) ## health
		for layer in range(1, 3):
			summon_instance.set_collision_layer_value(layer, layer != ability_handler.owner.group)
		summon_instance.ability_handler.inherited_damage["multiplier"] *= 0.25*level
		
		summon_instance.get_node("Sprite").modulate = Config.get_team_color(ability_handler.owner.group, "tertiary")
		
		summon_instance.ability_handler.grant("cryonic_volatility", level)
		
		get_node("/root/Main").spawn_entity(summon_instance)
