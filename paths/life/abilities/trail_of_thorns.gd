extends Ability

var bullet = preload("res://paths/life/spike.tscn")

var charge = 0
var pain_walk: bool
var pain_walk_counter: int

func _ready() -> void:
	ability_handler.movement.connect(movement)

func spawn(spawn_position):
	var bullet_instance = ability_handler.make_projectile(bullet, 
	spawn_position, 
	2,
	Vector2())
	bullet_instance.ability_handler.inherited_damage["multiplier"] *= 0.5 * level
	get_node("/root/Main/Projectiles").add_child(bullet_instance)

func movement(distance) -> void:
	charge += distance
	if charge >= 75:
		charge -= 75
		if pain_walk:
			for i in 2:
				spawn(ability_handler.owner.global_position + Vector2(randf_range(-24, 24), randf_range(-24, 24)))
			if ability_handler.is_entity:
				pain_walk_counter = (pain_walk_counter + 1) % 2
				if pain_walk_counter == 0:
					ability_handler.deal_damage(ability_handler.owner, {"base" : 2, "multiplier" : 1.0, "skip_input_modifiers": true, "skip_output_modifiers": true, "skip_immunity": true}, Config.get_team_color(1, "tertiary"))
		else:
			spawn(ability_handler.owner.global_position)

func inherit(handler, tier):
	if tier < 3:
		return
	super(handler, tier)
