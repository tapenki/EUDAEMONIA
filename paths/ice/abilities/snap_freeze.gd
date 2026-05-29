extends Ability

var status: Node

func _ready() -> void:
	status = ability_handler.learn("freeze", 0)
	get_node("/root/Main").entity_manifestation.connect(entity_manifestation)

func entity_manifestation(entity: Entity):
	for ability_relay in applicants:
		if applicants[ability_relay].has("subscription") and applicants[ability_relay]["subscription"] < 5:
			return
		status.apply(entity.ability_relay, {"duration" = 2.5 * ability_relay.get_effect_duration()})
