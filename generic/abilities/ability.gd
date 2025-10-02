class_name Ability extends Node2D

@onready var ability_handler = $"../"

@export var level: float
var level_offset: float
var level_multiplier: float = 1

var offsetting: bool
var cleared: bool

func kill():
	call_deferred("free")

func offset():
	offsetting = false
	level += level_offset
	level *= level_multiplier
	level_offset = 0
	level_multiplier = 1
	if level <= 0:
		kill()

func add_level(value):
	level_offset += value
	if not offsetting:
		offsetting = true
		call_deferred("offset")

func mult_level(value):
	level_multiplier *= value
	if not offsetting:
		offsetting = true
		call_deferred("offset")

func clear():
	if not cleared:
		cleared = true
		level_offset -= level
		if not offsetting:
			offsetting = true
			call_deferred("offset")

func write():
	return {"level" : level}

func read(data):
	level = data["level"]
