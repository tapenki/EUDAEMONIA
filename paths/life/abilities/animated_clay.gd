extends Ability

var summon = preload("res://paths/life/clay/clay.tscn")

var multimold: bool

func apply(ability_relay, applicant_data):
	if ability_relay.owner.scene_file_path == "res://paths/life/clay/clay.tscn":
		ability_relay.max_health_modifiers.connect(max_health_modifiers)
	super(ability_relay, applicant_data)

func disapply(ability_relay):
	super(ability_relay)
	if ability_relay.max_health_modifiers.is_connected(max_health_modifiers):
		ability_relay.max_health_modifiers.disconnect(max_health_modifiers)

func _ready() -> void:
	get_node("/root/Main").day_start.connect(day_start)
	
func day_start(_day: int) -> void:
	for ability_relay in applicants:
		if applicants[ability_relay].has("subscription") and applicants[ability_relay]["subscription"] < 5:
			return
		var offsets = [Vector2(0, 60)]
		if multimold:
			offsets = [Vector2(15, 60), Vector2(-15, 60)]
		var entrance_door = get_node("/root/Main").room_node.get_node("Doors/"+get_node("/root/Main").door)
		for summon_offset in offsets:
			var summon_position = entrance_door.global_position + summon_offset.rotated(entrance_door.rotation)
			var summon_instance = ability_relay.make_summon(summon, 
			summon_position, 
			{"subscription" = 3})  ## inheritance
			get_node("/root/Main").spawn_entity(summon_instance)

func max_health_modifiers(modifiers) -> void:
	modifiers["base"] += 80 * level
	if multimold:
		modifiers["multiplier"] *= 0.5
