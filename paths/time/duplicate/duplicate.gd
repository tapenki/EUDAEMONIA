extends Entity

func _ready() -> void:
	super()
	get_node("Lifetime").start(1.5 * ability_relay.get_effect_duration())

func _on_lifetime_timeout() -> void:
	kill.call_deferred()
