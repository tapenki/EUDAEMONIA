extends Ability

var bullet = preload("res://generic/projectiles/bullet.tscn")

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 5:
		return
	super(ability_relay, applicant_data)

func _ready() -> void:
	get_node("/root/Main").entity_death.connect(entity_death)

func entity_death(dying_entity: Entity):
	for applicant in applicants:
		var damage_mult = level
		var total = 3
		if dying_entity.summoned:
			total = 1
		var angle = randf_range(0, TAU)
		var target = applicant.find_target(dying_entity.global_position, 9999, {dying_entity : true})
		if target:
			angle = dying_entity.global_position.direction_to(target.global_position).angle()
		for repeat in total:
			var bullet_instance = applicant.make_projectile(bullet, 
			dying_entity.global_position, 
			2,
			Vector2.from_angle(angle + (TAU / total * repeat)) * 600)
			bullet_instance.exclude[dying_entity] = INF
			bullet_instance.ability_relay.inherited_damage["multiplier"] *= damage_mult
			bullet_instance.ability_relay.inherited_scale["multiplier"] *= 1.2
			get_node("/root/Main/Projectiles").add_child(bullet_instance)
