extends State

@export var command_state: String

@export var next: State

func on_enter() -> void:
	super()
	if state_handler.data.has("summons"):
		for summon in state_handler.data["summons"]:
			var summon_state_handler = summon.get_node_or_null("CommandHandler")
			if summon_state_handler:
				var summon_state = summon_state_handler.get_node_or_null(command_state)
				if summon_state:# and not summon_state_handler.current_state:
					summon_change_state(summon_state)
	change_state(next)
