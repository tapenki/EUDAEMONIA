extends Ability

var inheritance_level = 4

var summon = preload("res://paths/red_magic/flaming_skull/flaming_skull.tscn")

var undying_flames: bool

func _ready() -> void:
	if ability_handler.has_node("undying_flames"):
		undying_flames = true
	get_node("/root/Main").day_start.connect(day_start)
	get_node("/root/Main").entity_death.connect(entity_death)

func spawn(spawn_position: Vector2):
	var summon_instance = ability_handler.make_summon(summon, 
	spawn_position,
	3,  ## inheritance
	35 * level) ## health
	summon_instance.ability_handler.inherited_damage["multiplier"] *= level
	summon_instance.ability_handler.grant("fireburst", level)
	get_node("/root/Main").spawn_entity(summon_instance)

func day_start(_day: int) -> void:
	var summon_positions = [
		get_node("/root/Main").layout.get_node("Positions/InnerLeft").global_position,
		get_node("/root/Main").layout.get_node("Positions/InnerTop").global_position,
		get_node("/root/Main").layout.get_node("Positions/InnerRight").global_position,
		get_node("/root/Main").layout.get_node("Positions/InnerBottom").global_position,
	]
	for i in summon_positions:
		spawn(i)

func entity_death(dying_entity: Entity):
	if undying_flames and dying_entity.scene_file_path == "res://paths/red_magic/flaming_skull/flaming_skull.tscn":
		spawn(dying_entity.global_position)
