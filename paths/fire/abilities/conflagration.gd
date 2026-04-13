extends Ability

var status: Node

var inferno: bool

func apply(ability_relay, applicant_data):
	if applicant_data.has("subscription") and applicant_data["subscription"] < 5:
		return
	super(ability_relay, applicant_data)

func _ready() -> void:
	status = ability_handler.learn("burn", 0)
	get_node("/root/Main").entity_death.connect(entity_death)
	
func entity_death(dying_entity: Entity):
	for ability_relay in applicants:
		if status.applicants.has(dying_entity.ability_relay):
			var targets = 0
			var max_targets = 1
			if inferno:
				max_targets = 2
			for entity in ability_relay.area_targets(dying_entity.global_position, 9999):
				if entity != ability_relay.owner and entity != dying_entity and not entity.unchaseable:
					status.apply(entity.ability_relay, {"stacks" = min(10 * level, status.applicants[dying_entity.ability_relay]["stacks"])})
					get_node("/root/Main/ParticleHandler").particle_beam("common", 
					preload("res://paths/fire/flame.png"),
					dying_entity.global_position,
					entity.global_position,
					1.0,
					32,
					Config.get_team_color(ability_relay.owner.group, "secondary"))
					targets += 1
					if targets >= max_targets:
						break
