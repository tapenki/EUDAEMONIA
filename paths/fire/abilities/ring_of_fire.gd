extends Ability

var projectile_scene = preload("res://paths/fire/ring_of_fire/ring_of_fire.tscn")
var projectile

var scorched_earth

func _ready() -> void:
	scorched_earth = ability_handler.get_node_or_null("scorched_earth")
	if not scorched_earth:
		return
	get_node("/root/Main").day_start.connect(day_start)
	get_node("/root/Main").intermission.connect(intermission)

func day_start(_day: int) -> void:
	var projectile_instance = ability_handler.make_projectile(projectile_scene, 
	Vector2(),
	2,
	Vector2())
	projectile_instance.ability_handler.inherited_damage["multiplier"] *= 0.25 * scorched_earth.level
	projectile_instance.get_node("Sprite").ability_handler = ability_handler
	projectile_instance.get_node("Sprite/Particles").ability_handler = ability_handler
	add_child(projectile_instance)
	projectile = projectile_instance

func intermission(_day: int) -> void:
	projectile.queue_free()

func inherit(_handler, _tier):
	return
