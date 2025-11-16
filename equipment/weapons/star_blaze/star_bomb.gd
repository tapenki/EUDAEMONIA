extends Projectile

var splosion = preload("res://generic/projectiles/explosion.tscn")

func _ready() -> void:
	ability_handler.death_effects.connect(death_effects)

func death_effects() -> void:
	var splosion_instance = ability_handler.make_projectile(splosion, 
	global_position, 
	1)
	splosion_instance.scale_multiplier += (hits_left-1)*0.5
	get_node("/root/Main/Projectiles").add_child(splosion_instance)

func on_hit(crits):
	on_collision(crits)
	kill()
