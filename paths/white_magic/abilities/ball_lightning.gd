extends Ability

var inheritance_level = 4

var projectile_scene = preload("res://paths/white_magic/ball_lightning.tscn")
var anchor_node
var hurtbox_one
var hurtbox_two

var dynamo: bool
var speed = 1.0

func _ready() -> void:
	anchor_node = Node2D.new()
	add_child(anchor_node)
	if ability_handler.has_node("dynamo"):
		dynamo = true
	ability_handler.attack.connect(attack)
	get_node("/root/Main").day_start.connect(day_start)
	get_node("/root/Main").intermission.connect(intermission)

func _physics_process(delta: float) -> void:
	if dynamo:
		speed = min(speed + delta * ability_handler.speed_scale * 0.25, 2)
	anchor_node.rotation += delta * PI * ability_handler.speed_scale * speed

func attack(_direction):
	speed = 1.0

func day_start(_day: int) -> void:
	var total = 2
	for repeat in total:
		var projectile_instance = ability_handler.make_projectile(projectile_scene, 
		Vector2.from_angle(TAU / total * repeat) * 150,
		3,
		Vector2())
		projectile_instance.ability_handler.inherited_damage["multiplier"] *= level
		projectile_instance.ability_handler.inherited_crit_chance["multiplier"] *= 2
		projectile_instance.get_node("Sprite").rotation = (Vector2.from_angle(PI * 0.5 + (TAU / total * repeat)) * 150).angle()
		anchor_node.add_child(projectile_instance)

func intermission(_day: int) -> void:
	for projectile in anchor_node.get_children():
		projectile.queue_free()

func kill():
	for projectile in anchor_node.get_children():
		projectile.get_node("Sprite/Charge").modulate = projectile.get_node("Sprite").modulate
		projectile.get_node("Sprite/Charge").parent_died()
	super()
