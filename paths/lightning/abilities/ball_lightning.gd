extends Ability

var projectile_scene = preload("res://paths/lightning/ball_lightning.tscn")
var anchor_node

var close_orbit: bool
var orbit_speed = 1

func _ready() -> void:
	anchor_node = Node2D.new()
	add_child(anchor_node)
	get_node("/root/Main").day_start.connect(day_start)
	get_node("/root/Main").intermission.connect(intermission)

func _physics_process(delta: float) -> void:
	anchor_node.rotation += delta * PI * orbit_speed * ability_handler.speed_scale

func day_start(_day: int) -> void:
	var distance = 150
	if close_orbit:
		distance = 90
		orbit_speed = 2
	var total = 2
	for repeat in total:
		var projectile_instance = ability_handler.make_projectile(projectile_scene, 
		Vector2.from_angle(TAU / total * repeat) * distance,
		2,
		Vector2())
		projectile_instance.ability_handler.inherited_damage["multiplier"] *= level
		projectile_instance.ability_handler.inherited_crit_chance["multiplier"] *= 2
		projectile_instance.get_node("Sprite").rotation = (Vector2.from_angle(PI * 0.5 + (TAU / total * repeat)) * 150).angle()
		projectile_instance.get_node("Sprite/Particles").ability_handler = ability_handler
		anchor_node.add_child(projectile_instance)

func intermission(_day: int) -> void:
	for projectile in anchor_node.get_children():
		projectile.queue_free()

func inherit(_handler, _tier):
	return
