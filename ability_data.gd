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
	## red
	"ignition" : {
		"script" : preload("res://paths/red_magic/abilities/ignition.gd"),
		"type" : "upgrade"
	},
	"firespawning" : {
		"script" : preload("res://paths/red_magic/abilities/firespawning.gd"),
		"type" : "upgrade"
	},
	"conflagration" : {
		"script" : preload("res://paths/red_magic/abilities/conflagration.gd"),
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
	"burn" : {
		"script" : preload("res://generic/abilities/status/burn.gd"),
		"type" : "status"
	},
	## blue
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
		"script" : preload("res://generic/abilities/status/chill.gd"),
		"type" : "status"
	},
	"ice_bombs" : {
		"script" : preload("res://paths/blue_magic/abilities/ice_bombs.gd"),
		"type" : "upgrade"
	},
	"bomb" : {
		"script" : preload("res://paths/blue_magic/icebomb/bomb.gd"),
		"type" : "token"
	},
	## black
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
	## white
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
	## misc
	"bonus_health" : {
		"script" : preload("res://generic/abilities/bonus_health.gd"),
		"type" : "token"
	},
	"bulletsplosion" : {
		"script" : preload("res://generic/abilities/enemy/bulletsplosion.gd"),
		"type" : "token"
	},
}
