extends Ability

var bullet = preload("res://paths/fire/scorched_earth/scorched_earth.tscn")

func _ready() -> void:
	ability_handler.death_effects.connect(death_effects)
	
func death_effects() -> void:
	if not ability_handler.is_projectile:
		return
	var odds = {"base": 50, "multiplier": 1.0}
	if not ability_handler.roll_chance(odds):
		return
	var bullet_instance = ability_handler.make_projectile(bullet, 
	global_position, 
	1,
	Vector2())
	bullet_instance.ability_handler.inherited_damage["multiplier"] *= 0.25 * level
	get_node("/root/Main/Projectiles").add_child(bullet_instance)

func inherit(handler, tier):
	if tier < 2:
		return
	super(handler, tier)
