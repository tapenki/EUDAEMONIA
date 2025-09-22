class_name State
extends Node

@onready var state_handler = $"../"
@onready var user = $"../../"

func on_enter() -> void:
	process_mode = ProcessMode.PROCESS_MODE_INHERIT

func on_exit() -> void:
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
