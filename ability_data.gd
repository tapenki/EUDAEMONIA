extends Node

var path_data = {
	"pyromancy" : {
		"scene" : preload("res://paths/pyromancy/pyromancy.tscn"),
	},
	"cryomancy" : {
		"scene" : preload("res://paths/cryomancy/cryomancy.tscn"),
	},
	"electromancy" : {
		"scene" : preload("res://paths/electromancy/electromancy.tscn"),
	},
	"druidry" : {
		"scene" : preload("res://paths/druidry/druidry.tscn"),
	},
	"necromancy" : {
		"scene" : preload("res://paths/necromancy/necromancy.tscn"),
	},
}

var ability_data = {
	#region weapons
	"magic_missile" : {
		"script" : preload("res://equipment/weapons/magic_missile/magic_missile.gd"),
		"type" : "weapon"
	},
	"star_blaze" : {
		"script" : preload("res://equipment/weapons/star_blaze/star_blaze.gd"),
		"type" : "weapon"
	},
	"category_one" : {
		"script" : preload("res://equipment/weapons/category_one/category_one.gd"),
		"type" : "weapon"
	},
	"trick_bullets" : {
		"script" : preload("res://equipment/weapons/trick_bullets/trick_bullets.gd"),
		"type" : "weapon"
	},
	#endregion
	#region armor
	"hermits_cloak" : {
		"script" : preload("res://equipment/armor/hermits_cloak/hermits_cloak.gd"),
		"type" : "armor"
	},
	"mystic_robes" : {
		"script" : preload("res://equipment/armor/mystic_robes/mystic_robes.gd"),
		"type" : "armor"
	},
	"cursemail" : {
		"script" : preload("res://equipment/armor/cursemail/cursemail.gd"),
		"type" : "armor"
	},
	#endregion
	#region pyromancy
	"ignition" : {
		"script" : preload("res://paths/pyromancy/abilities/ignition.gd"),
		"type" : "upgrade"
	},
	"firespawning" : {
		"script" : preload("res://paths/pyromancy/abilities/firespawning.gd"),
		"type" : "upgrade"
	},
	"fireburst" : {
		"script" : preload("res://paths/pyromancy/flaming_skull/fireburst.gd"),
		"type" : "token"
	},
	"melt" : {
		"script" : preload("res://paths/pyromancy/abilities/melt.gd"),
		"type" : "upgrade"
	},
	"scorched_earth" : {
		"script" : preload("res://paths/pyromancy/abilities/scorched_earth.gd"),
		"type" : "upgrade"
	},
	"from_ashes" : {
		"script" : preload("res://paths/pyromancy/abilities/from_ashes.gd"),
		"type" : "upgrade"
	},
	"conflagration" : {
		"script" : preload("res://paths/pyromancy/abilities/conflagration.gd"),
		"type" : "mastery"
	},
	"undying_flames" : {
		"script" : preload("res://paths/pyromancy/abilities/undying_flames.gd"),
		"type" : "mastery"
	},
	"fiery_rebirth" : {
		"script" : preload("res://paths/pyromancy/abilities/fiery_rebirth.gd"),
		"type" : "mastery"
	},
	"burn" : {
		"script" : preload("res://paths/pyromancy/burn.gd"),
		"type" : "status"
	},
	#endregion
	#region cryomancy
	"blue_needle" : {
		"script" : preload("res://paths/cryomancy/abilities/blue_needle.gd"),
		"type" : "upgrade"
	},
	"snowball" : {
		"script" : preload("res://paths/cryomancy/abilities/snowball.gd"),
		"type" : "upgrade"
	},
	"shatter" : {
		"script" : preload("res://paths/cryomancy/abilities/shatter.gd"),
		"type" : "upgrade"
	},
	"frostbite" : {
		"script" : preload("res://paths/cryomancy/abilities/frostbite.gd"),
		"type" : "upgrade"
	},
	"chill" : {
		"script" : preload("res://paths/cryomancy/chill.gd"),
		"type" : "status"
	},
	"cryobombs" : {
		"script" : preload("res://paths/cryomancy/abilities/cryobombs.gd"),
		"type" : "upgrade"
	},
	"cryonic_volatility" : {
		"script" : preload("res://paths/cryomancy/cryobomb/cryonic_volatility.gd"),
		"type" : "token"
	},
	"snowball_ii" : {
		"script" : preload("res://paths/cryomancy/abilities/snowball_ii.gd"),
		"type" : "mastery"
	},
	"snap_freeze" : {
		"script" : preload("res://paths/cryomancy/abilities/snap_freeze.gd"),
		"type" : "mastery"
	},
	"freeze" : {
		"script" : preload("res://paths/cryomancy/freeze.gd"),
		"type" : "status"
	},
	"shard_blast" : {
		"script" : preload("res://paths/cryomancy/abilities/shard_blast.gd"),
		"type" : "mastery"
	},
	#endregion
	#region electromancy
	"chain_bolt" : {
		"script" : preload("res://paths/electromancy/abilities/chain_bolt.gd"),
		"type" : "upgrade"
	},
	"mortal_shock" : {
		"script" : preload("res://paths/electromancy/abilities/mortal_shock.gd"),
		"type" : "upgrade"
	},
	"electromagnetism" : {
		"script" : preload("res://paths/electromancy/abilities/electromagnetism.gd"),
		"type" : "upgrade"
	},
	"ball_lightning" : {
		"script" : preload("res://paths/electromancy/abilities/ball_lightning.gd"),
		"type" : "upgrade"
	},
	"thunderstep" : {
		"script" : preload("res://paths/electromancy/abilities/thunderstep.gd"),
		"type" : "upgrade"
	},
	"shocking_grasp" : {
		"script" : preload("res://paths/electromancy/abilities/shocking_grasp.gd"),
		"type" : "mastery"
	},
	"shock" : {
		"script" : preload("res://paths/electromancy/shock.gd"),
		"type" : "status"
	},
	"dynamo" : {
		"script" : preload("res://paths/electromancy/abilities/dynamo.gd"),
		"type" : "mastery"
	},
	"repulsar" : {
		"script" : preload("res://paths/electromancy/abilities/repulsar.gd"),
		"type" : "mastery"
	},
	#endregion
	#region druidry
	"primal_casting" : {
		"script" : preload("res://paths/druidry/abilities/primal_casting.gd"),
		"type" : "upgrade"
	},
	"trail_of_thorns" : {
		"script" : preload("res://paths/druidry/abilities/trail_of_thorns.gd"),
		"type" : "upgrade"
	},
	"quill_spray" : {
		"script" : preload("res://paths/druidry/abilities/quill_spray.gd"),
		"type" : "upgrade"
	},
	"wrought_flesh" : {
		"script" : preload("res://paths/druidry/abilities/wrought_flesh.gd"),
		"type" : "upgrade"
	},
	"animated_clay" : {
		"script" : preload("res://paths/druidry/abilities/animated_clay.gd"),
		"type" : "upgrade"
	},
	"pain_walk" : {
		"script" : preload("res://paths/druidry/abilities/pain_walk.gd"),
		"type" : "mastery"
	},
	"pressurized_quills" : {
		"script" : preload("res://paths/druidry/abilities/pressurized_quills.gd"),
		"type" : "mastery"
	},
	"multimold" : {
		"script" : preload("res://paths/druidry/abilities/multimold.gd"),
		"type" : "mastery"
	},
	#endregion
	#region necromancy
	"army_of_the_dead" : {
		"script" : preload("res://paths/necromancy/abilities/army_of_the_dead.gd"),
		"type" : "upgrade"
	},
	"death_touch" : {
		"script" : preload("res://paths/necromancy/abilities/death_touch.gd"),
		"type" : "upgrade"
	},
	"hunger" : {
		"script" : preload("res://paths/necromancy/abilities/hunger.gd"),
		"type" : "upgrade"
	},
	"bone_shield" : {
		"script" : preload("res://paths/necromancy/abilities/bone_shield.gd"),
		"type" : "upgrade"
	},
	"dark_harvest" : {
		"script" : preload("res://paths/necromancy/abilities/dark_harvest.gd"),
		"type" : "upgrade"
	},
	"ante_mortem" : {
		"script" : preload("res://paths/necromancy/abilities/bone_spear.gd"),
		"type" : "mastery"
	},
	"starvation" : {
		"script" : preload("res://paths/necromancy/abilities/starvation.gd"),
		"type" : "mastery"
	},
	"bone_spear" : {
		"script" : preload("res://paths/necromancy/abilities/bone_spear.gd"),
		"type" : "mastery"
	},
	#endregion
	#region misc
	"bonus_health" : {
		"script" : preload("res://generic/abilities/bonus_health.gd"),
		"type" : "token"
	},
	"dark_price" : {
		"script" : preload("res://generic/abilities/dark_price.gd"),
		"type" : "token"
	},
	"haste" : {
		"script" : preload("res://generic/abilities/status/haste.gd"),
		"type" : "status"
	},
	#endregion
}
