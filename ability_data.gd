extends Node

var path_data = {
	"red_magic" : {
		"scene" : preload("res://paths/red_magic/red_magic.tscn"),
	},
	"blue_magic" : {
		"scene" : preload("res://paths/blue_magic/blue_magic.tscn"),
	},
	"black_magic" : {
		"scene" : preload("res://paths/black_magic/black_magic.tscn"),
	},
	"white_magic" : {
		"scene" : preload("res://paths/white_magic/white_magic.tscn"),
	},
}

var ability_data = {
	#region red
	"ignition" : {
		"script" : preload("res://paths/red_magic/abilities/ignition.gd"),
		"type" : "upgrade"
	},
	"firespawning" : {
		"script" : preload("res://paths/red_magic/abilities/firespawning.gd"),
		"type" : "upgrade"
	},
	"fireburst" : {
		"script" : preload("res://paths/red_magic/flaming_skull/fireburst.gd"),
		"type" : "token"
	},
	"melt" : {
		"script" : preload("res://paths/red_magic/abilities/melt.gd"),
		"type" : "upgrade"
	},
	"scorched_earth" : {
		"script" : preload("res://paths/red_magic/abilities/scorched_earth.gd"),
		"type" : "upgrade"
	},
	"from_ashes" : {
		"script" : preload("res://paths/red_magic/abilities/from_ashes.gd"),
		"type" : "upgrade"
	},
	"conflagration" : {
		"script" : preload("res://paths/red_magic/abilities/conflagration.gd"),
		"type" : "mastery"
	},
	"undying_flames" : {
		"script" : preload("res://paths/red_magic/abilities/undying_flames.gd"),
		"type" : "mastery"
	},
	"fiery_rebirth" : {
		"script" : preload("res://paths/red_magic/abilities/fiery_rebirth.gd"),
		"type" : "mastery"
	},
	"burn" : {
		"script" : preload("res://paths/red_magic/burn.gd"),
		"type" : "status"
	},
	#endregion
	#region blue
	"blue_needle" : {
		"script" : preload("res://paths/blue_magic/abilities/blue_needle.gd"),
		"type" : "upgrade"
	},
	"snowball" : {
		"script" : preload("res://paths/blue_magic/abilities/snowball.gd"),
		"type" : "upgrade"
	},
	"shatter" : {
		"script" : preload("res://paths/blue_magic/abilities/shatter.gd"),
		"type" : "upgrade"
	},
	"frostbite" : {
		"script" : preload("res://paths/blue_magic/abilities/frostbite.gd"),
		"type" : "upgrade"
	},
	"chill" : {
		"script" : preload("res://paths/blue_magic/chill.gd"),
		"type" : "status"
	},
	"cryobombs" : {
		"script" : preload("res://paths/blue_magic/abilities/cryobombs.gd"),
		"type" : "upgrade"
	},
	"cryonic_volatility" : {
		"script" : preload("res://paths/blue_magic/cryobomb/cryonic_volatility.gd"),
		"type" : "token"
	},
	"snowball_ii" : {
		"script" : preload("res://paths/blue_magic/abilities/snowball_ii.gd"),
		"type" : "mastery"
	},
	"snap_freeze" : {
		"script" : preload("res://paths/blue_magic/abilities/snap_freeze.gd"),
		"type" : "mastery"
	},
	"freeze" : {
		"script" : preload("res://paths/blue_magic/freeze.gd"),
		"type" : "status"
	},
	"shard_blast" : {
		"script" : preload("res://paths/blue_magic/abilities/shard_blast.gd"),
		"type" : "mastery"
	},
	#endregion
	#region black
	"primal_casting" : {
		"script" : preload("res://paths/black_magic/abilities/primal_casting.gd"),
		"type" : "upgrade"
	},
	"trail_of_thorns" : {
		"script" : preload("res://paths/black_magic/abilities/trail_of_thorns.gd"),
		"type" : "upgrade"
	},
	"quill_spray" : {
		"script" : preload("res://paths/black_magic/abilities/quill_spray.gd"),
		"type" : "upgrade"
	},
	"wrought_flesh" : {
		"script" : preload("res://paths/black_magic/abilities/wrought_flesh.gd"),
		"type" : "upgrade"
	},
	"animated_clay" : {
		"script" : preload("res://paths/black_magic/abilities/animated_clay.gd"),
		"type" : "upgrade"
	},
	"pain_walk" : {
		"script" : preload("res://paths/black_magic/abilities/pain_walk.gd"),
		"type" : "mastery"
	},
	"pressurized_quills" : {
		"script" : preload("res://paths/black_magic/abilities/pressurized_quills.gd"),
		"type" : "mastery"
	},
	"multimold" : {
		"script" : preload("res://paths/black_magic/abilities/multimold.gd"),
		"type" : "mastery"
	},
	#endregion
	#region white
	"chain_bolt" : {
		"script" : preload("res://paths/white_magic/abilities/chain_bolt.gd"),
		"type" : "upgrade"
	},
	"mortal_shock" : {
		"script" : preload("res://paths/white_magic/abilities/mortal_shock.gd"),
		"type" : "upgrade"
	},
	"electromagnetism" : {
		"script" : preload("res://paths/white_magic/abilities/electromagnetism.gd"),
		"type" : "upgrade"
	},
	"ball_lightning" : {
		"script" : preload("res://paths/white_magic/abilities/ball_lightning.gd"),
		"type" : "upgrade"
	},
	"thunderstep" : {
		"script" : preload("res://paths/white_magic/abilities/thunderstep.gd"),
		"type" : "upgrade"
	},
	"shocking_grasp" : {
		"script" : preload("res://paths/white_magic/abilities/shocking_grasp.gd"),
		"type" : "mastery"
	},
	"shock" : {
		"script" : preload("res://paths/white_magic/shock.gd"),
		"type" : "status"
	},
	"dynamo" : {
		"script" : preload("res://paths/white_magic/abilities/dynamo.gd"),
		"type" : "mastery"
	},
	"repulsar" : {
		"script" : preload("res://paths/white_magic/abilities/repulsar.gd"),
		"type" : "mastery"
	},
	#endregion
	#region misc
	"bonus_health" : {
		"script" : preload("res://generic/abilities/bonus_health.gd"),
		"type" : "token"
	},
	#endregion
}
