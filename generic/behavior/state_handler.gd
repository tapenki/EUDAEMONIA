class_name StateHandler extends Node

#@onready var user = get_node("..")
@onready var ability_relay = get_node("../AbilityRelay")

@export var initial_state: State
var current_states: Array

var data: Dictionary
var target

var disabled = false

func _ready() -> void:
	ability_relay.self_death.connect(self_death)
	initial_state.on_enter()
	
func self_death():
	#process_mode = ProcessMode.PROCESS_MODE_DISABLED
	disabled = true
	for current_state in current_states:
		current_state.on_exit()
