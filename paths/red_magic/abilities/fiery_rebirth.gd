extends Ability

func _ready() -> void:
	var from_ashes = ability_handler.get_node_or_null("from_ashes")
	if from_ashes:
		from_ashes.fiery_rebirth = true

func inherit(handler, tier):
	if tier < 3:
		return
	super(handler, tier)
