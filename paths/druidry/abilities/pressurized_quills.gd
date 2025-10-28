extends Ability

func _ready() -> void:
	var quill_spray = ability_handler.get_node_or_null("quill_spray")
	if quill_spray:
		quill_spray.pressurized_quills = true

func inherit(handler, tier):
	if tier < 3:
		return
	super(handler, tier)
