extends Node2D

@onready var floating_text_font = preload("res://ui/damage_numbers_font.tres")
var floating_texts: Dictionary
func floating_text(text_position: Vector2, text: String, color: Color):
	var text_line = TextLine.new()
	floating_texts[text_line] = {"position" : text_position, "string" : text, "color" : color, "lifetime" : 1.2}

func _draw():
	for text in floating_texts:
		var text_size = text.get_size()
		var text_position = floating_texts[text]["position"] - text_size * 0.5
		text_position -= Vector2(0, 32) * (1 - pow(floating_texts[text]["lifetime"] / 1.2, 4))
		text.draw_outline(get_canvas_item(), text_position, 5, Color(0.25, 0.25, 0.25) * floating_texts[text]["color"])
		text.draw(get_canvas_item(), text_position, floating_texts[text]["color"])

func _process(delta: float) -> void:
	for text in floating_texts.keys():
		floating_texts[text]["lifetime"] -= delta
		if floating_texts[text]["lifetime"] <= 0:
			floating_texts.erase(text)
		else:
			var progress = 1
			if floating_texts[text]["lifetime"] > 1:
				progress = 1 - ((floating_texts[text]["lifetime"] - 1) / 0.2)
			elif floating_texts[text]["lifetime"] < 0.4:
				progress = (floating_texts[text]["lifetime"] / 0.4)
			text.clear()
			var font_size = ceil(20*progress)
			if font_size > 1:
				text.add_string(floating_texts[text]["string"], floating_text_font, font_size)
	queue_redraw()
