extends RichTextLabel

@onready var title = $Title
@onready var tag = $Title/Tag

var described: Node

var locked = false

func meta_hover_started(meta):
	print(meta) 

func meta_hover_ended(meta):
	print(meta) 

func lock():
	locked = true
	meta_underlined = true
	mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_ENABLED

func delock():
	locked = false
	meta_underlined = false
	mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_DISABLED
	if visible:
		check_mouse_position()

func check_mouse_position(): ## downright criminal
	var mouse_position = get_global_mouse_position()
	var described_position = described.global_position + described.size * 0.5
	
	var input = InputEventMouseMotion.new()
	input.position = described_position
	Input.parse_input_event(input)
	
	get_window().warp_mouse(mouse_position)

func set_title(title_text):
	title.text = title_text
	title.size = Vector2(260, title.get_content_height())
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

func describe(described_node: Node):
	if described:
		described.current_description = null
	described_node.current_description = self
	described = described_node
	
	set_title(described.get_title())
	set_description(described.get_description())
	set_tag(described.tag)
	
	var to_position = described.global_position + Vector2(described.size.x, described.size.y) * 0.5
	
	var winsize = get_window().content_scale_size ## horrible and evil solutions
	var ratio = float(get_window().size.x)/get_window().size.y
	if ratio > float(winsize.x)/winsize.y:
		winsize.x = winsize.y * ratio
	elif ratio < float(winsize.x)/winsize.y:
		winsize.y = winsize.x / ratio
	
	var quadrant = Vector2(1, 1)
	if to_position.y > winsize.y * 0.5:
		quadrant.y = -1
	if to_position.x > winsize.x * 0.5:
		quadrant.x = -1
	
	to_position += (Vector2(180, 0) + described.size * 0.5) * quadrant - Vector2(size.x, 0) * 0.5
	
	var name_offset = title.get_content_height() + 18
	var description_offset = get_content_height() + 6
	global_position = to_position.clamp(Vector2(6, name_offset), Vector2(winsize.x - 244, winsize.y - description_offset))
	visible = true

func undescribe():
	described = null
	visible = false
