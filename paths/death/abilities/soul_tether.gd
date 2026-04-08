extends Ability

func apply(_ability_relay, _applicant_data):
	return

func _ready() -> void:
	var army_of_the_dead = ability_handler.get_node_or_null("army_of_the_dead")
	if army_of_the_dead:
		army_of_the_dead.soul_tether = true
