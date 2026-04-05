#extends Ability
#
#func _ready() -> void:
	#var trail_of_thorns = ability_relay.get_node_or_null("trail_of_thorns")
	#if trail_of_thorns:
		#trail_of_thorns.pain_walk = true
#
#func inherit(handler, tier):
	#if tier < 3:
		#return
	#super(handler, tier)
