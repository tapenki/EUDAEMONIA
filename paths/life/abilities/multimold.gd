extends Ability

func _ready() -> void:
	var animated_clay = ability_handler.get_node_or_null("animated_clay")
	if animated_clay:
		animated_clay.multimold = true
	if ability_handler.owner.scene_file_path == "res://paths/life/clay/clay.tscn":
		ability_handler.max_health_modifiers.connect(max_health_modifiers)

func max_health_modifiers(modifiers) -> void:
	modifiers["multiplier"] *= 0.5

func inherit(handler, tier):
	if handler.owner.scene_file_path != "res://paths/life/clay/clay.tscn":
		return
	super(handler, tier)
