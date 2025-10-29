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
	cleared = false
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

func inherit(handler, _tier):
	var ability_node = handler.get_node_or_null(str(name))
	if not ability_node:
		ability_node = Node2D.new()
		ability_node.set_script(get_script())
		ability_node.name = name
		handler.add_child(ability_node)
	ability_node.level += level
	return ability_node

func serialize():
	return {"level" : level}

func deserialize(data):
	level = data["level"]
