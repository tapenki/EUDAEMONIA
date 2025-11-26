extends "res://ui/description.gd"
#
#@onready var secondary_description = get_node("/root/Main/UI/SecondaryDescription")
#
#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action("inspect"):
		#if Input.is_action_just_pressed("inspect"):
			#lock()
		#if Input.is_action_just_released("inspect"):
			#delock()
#
#func check_mouse_position():
	#if secondary_description.visible:
		#described.current_description = null
		#secondary_description.described.current_description = self
		#describe(secondary_description.described)
		#secondary_description.undescribe()
		#return
	#super()
