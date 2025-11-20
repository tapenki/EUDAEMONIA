extends RichTextLabel

@onready var title = $Title
@onready var tag = $Title/Tag

func set_title(title_text):
	title.text = title_text
	title.size = Vector2(240, title.get_content_height())
	title.position.y = -title.size.y - 4

func set_description(description_text):
	text = description_text
	size = Vector2(240, get_content_height())

func set_tag(tag_text):
	if tag_text == "":
		tag.visible = false
		return
	tag.text = tag_text
	tag.visible = true

func positionize(to_position):
	var winsize = get_window().content_scale_size ## horrible and evil solutions
	var ratio = float(get_window().size.x)/get_window().size.y
	if ratio > float(winsize.x)/winsize.y:
		winsize.x = winsize.y * ratio
	elif ratio < float(winsize.x)/winsize.y:
		winsize.y = winsize.x / ratio
	
	var name_offset = title.get_content_height() + 18
	var description_offset = get_content_height() + 6
	global_position = to_position.clamp(Vector2(6, name_offset), Vector2(winsize.x - 244, winsize.y - description_offset))
