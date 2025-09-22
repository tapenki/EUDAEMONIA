extends Node

@export var initial_state: State
var current_state: State

var data: Dictionary
var target

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)
	change_state(initial_state)

func enter_state(state: State):
	if process_mode != ProcessMode.PROCESS_MODE_DISABLED:
		current_state = state
		state.on_enter()

func change_state(state: State):
	if current_state:
		current_state.on_exit()
	call_deferred("enter_state", state)
	
func entity_death(dying_entity: Entity):
	if dying_entity == get_parent():
		process_mode = ProcessMode.PROCESS_MODE_DISABLED
		if current_state:
			current_state.on_exit()
