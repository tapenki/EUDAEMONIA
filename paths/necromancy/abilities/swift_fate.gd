extends Ability

func _ready() -> void:
	ability_handler.status_applied.connect(status_applied)

func status_applied(status, _levels):
	if status.name == "doom" and not status.swift_fate:
		status.swift_fate = true
		status.doom_timer.start(status.doom_timer.wait_time * 0.5)
