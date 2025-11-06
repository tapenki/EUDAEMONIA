extends Control

@onready var font = preload("res://ui/damage_numbers_font.tres")

@export var radius = 100
@export var rotation_speed = 1.0

@export var text: String
@export var text_color: Color
@export var font_size = 16
@export var outline_color: Color
@export var outline_size = 5

var letters: Array

var text_rotation: float

func _ready() -> void:
	for i in text:
		var text_line = TextLine.new()
		text_line.add_string(i, font, font_size)
		letters.append(text_line)
	letters.reverse()

func _draw():
	for i in letters.size():
		var text_line = letters[i]
		var text_size = text_line.get_size()
		var text_position = Vector2.from_angle(text_rotation + TAU / letters.size() * i) * radius - text_size * 0.5
		text_line.draw_outline(get_canvas_item(), text_position, outline_size, outline_color)
		text_line.draw(get_canvas_item(), text_position, text_color)

func _process(delta: float) -> void:
	text_rotation += delta * rotation_speed
	queue_redraw()
