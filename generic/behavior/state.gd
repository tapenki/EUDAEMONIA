class_name State
extends Node

@export var handler_name = "StateHandler"
@onready var state_handler = get_node("%" + handler_name)
@onready var user = state_handler.get_node("..")

func on_enter() -> void:
	state_handler.current_states.append(self)
	process_mode = ProcessMode.PROCESS_MODE_PAUSABLE

func on_exit() -> void:
	state_handler.current_states.erase(self)
	process_mode = ProcessMode.PROCESS_MODE_DISABLED

func pre_enter() -> void:
	if state_handler.disabled:
		return
	on_enter()

func change_state(state: State):
	on_exit()
	if state:
		state.call_deferred("pre_enter")
