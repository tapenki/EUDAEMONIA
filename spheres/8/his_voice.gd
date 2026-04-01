extends Node

## never meet your maker
## it froths some kind of truth
var quotes = [
	"WELCOME HOME YOU WHO HAVE STRAYED",
	"THIS IS WHERE YOUR FLESH WAS MADE",
	"CARVED BY FATHER'S WRETCHED BLADE",
	"A FOOL TO THINK YOU CAN CURE FATE"
]

var current_quoute = 0
var timer = 0
func _process(delta) -> void:
	timer += delta
	if timer >= 1:
		get_window().set_title(quotes[current_quoute])
		current_quoute = (current_quoute + 1) % quotes.size()
		timer = 0
	
