extends Ability

var inheritance_level = 3

var bullet = preload("res://paths/black_magic/spike.tscn")

var charge = 0
var pain_walk: bool
var pain_walk_counter: int

func _ready() -> void:
	if ability_handler.has_node("pain_walk"):
		pain_walk = true
	ability_handler.movement.connect(movement)

func spawn(spawn_position):
	var bullet_instance = ability_handler.make_projectile(bullet, 
	spawn_position, 
	3,
	Vector2())
	bullet_instance.ability_handler.inherited_damage["multiplier"] *= level
	get_node("/root/Main/Projectiles").add_child(bullet_instance)

func movement(distance) -> void:
	charge += distance
	if charge >= 75:
		charge -= 75
		if pain_walk:
			for i in 2:
				spawn(ability_handler.owner.global_position + Vector2(randf_range(-24, 24), randf_range(-24, 24)))
			if ability_handler.type == "entity":
				pain_walk_counter = (pain_walk_counter + 1) % 2
				if pain_walk_counter == 0:
					ability_handler.owner.take_damage(ability_handler, 2, false)
					if Config.config.get_value("gameplay", "damage_numbers"): ## damage numbers
						get_node("/root/Main").floating_text(global_position + Vector2(randi_range(-16, 16), -16 + randi_range(-16, 16)), str(2), Config.get_team_color(1, "secondary"))
		else:
			spawn(ability_handler.owner.global_position)
