extends Ability

var inheritance_level = 4

var bomb = preload("res://paths/blue_magic/cryobomb/cryobomb.tscn")

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)
	
func day_start(_day: int) -> void:
	var summon_positions = [
		get_node("/root/Main").layout.get_node("Positions/InnerLeft").global_position,
		get_node("/root/Main").layout.get_node("Positions/InnerRight").global_position,
	]
	for i in summon_positions:
		var summon_instance = ability_handler.make_summon(bomb, 
		i,
		3,  ## inheritance
		0) ## health
		for layer in range(1, 3):
			summon_instance.set_collision_layer_value(layer, layer != ability_handler.owner.group)
		summon_instance.ability_handler.inherited_damage["multiplier"] *= 0.25*level
		
		summon_instance.get_node("Sprite").modulate = Config.get_team_color(3, "secondary")
		
		summon_instance.ability_handler.grant("cryonic_volatility", level)
		
		get_node("/root/Main").spawn_entity(summon_instance)
