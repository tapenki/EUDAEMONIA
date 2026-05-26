extends Projectile

var splosion = preload("res://generic/projectiles/weak_explosion.tscn")

func hit_effects(crits: int):
	var splosion_instance = ability_relay.make_projectile(splosion, 
	global_position, 
	{"subscription" = 1})
	#splosion_instance.scale_multiplier = 1
	get_node("/root/Main/Projectiles").add_child(splosion_instance)
	super(crits)
