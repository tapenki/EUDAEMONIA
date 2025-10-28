extends Ability

var bullet = preload("res://paths/pyromancy/scorched_earth.tscn")

func _ready() -> void:
	ability_handler.self_death.connect(self_death)
	
func self_death() -> void:
	var bullet_instance = ability_handler.make_projectile(bullet, 
	global_position, 
	1,
	Vector2())
	bullet_instance.ability_handler.inherited_damage["multiplier"] *= 0.25 * level
	if ability_handler.type == "entity":
		bullet_instance.ability_handler.inherited_scale["multiplier"] *= 1.5
	get_node("/root/Main/Projectiles").add_child(bullet_instance)

func inherit(handler, tier):
	if tier < 2:
		return
	super(handler, tier)
