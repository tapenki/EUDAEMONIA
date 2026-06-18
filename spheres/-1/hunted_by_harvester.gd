extends Ability

var harvester_scene = preload("res://spheres/-1/harvester.tscn")

var time = 0.0
var active = true

func apply(ability_relay, applicant_data):
	if not applicant_data.has("subscription") or applicant_data["subscription"] < 5:
		return
	super(ability_relay, applicant_data)

func _ready() -> void:
	get_node("/root/Main").intermission.connect(intermission)

func intermission(_day: int) -> void:
	time = 0.0
	active = true

func _physics_process(delta: float) -> void:
	if not active:
		return
	time += delta
	if time >= 150:
		time = 0.0
		active = false
		for applicant in applicants:
			var entrance_door = get_node("/root/Main").room_node.get_node("Doors/"+get_node("/root/Main").door)
			var harvester_instance = harvester_scene.instantiate()
			harvester_instance.global_position = entrance_door.global_position
			harvester_instance.target = applicant.owner
			get_node("/root/Main").room_node.add_child(harvester_instance)
