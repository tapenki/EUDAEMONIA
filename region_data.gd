extends Node

var room_data = {
	#region vasis
	"vasis_entrance_hall" : {
		"scene" : preload("res://regions/vasis/rooms/vasis_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"vasis_room_0" : {
		"scene" : preload("res://regions/vasis/rooms/vasis_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"vasis_room_1" : {
		"scene" : preload("res://regions/vasis/rooms/vasis_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"vasis_room_2" : {
		"scene" : preload("res://regions/vasis/rooms/vasis_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
	},
	"vasis_throne_room" : {
		"scene" : preload("res://regions/vasis/rooms/vasis_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "vasis",
		"challenge" : true,
	},
	#endregion
	#region thayma
	"thayma_entrance_hall" : {
		"scene" : preload("res://regions/thayma/rooms/thayma_entrance_hall.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_room_0" : {
		"scene" : preload("res://regions/thayma/rooms/thayma_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_room_1" : {
		"scene" : preload("res://regions/thayma/rooms/thayma_room_1.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_room_2" : {
		"scene" : preload("res://regions/thayma/rooms/thayma_room_2.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
	},
	"thayma_throne_room" : {
		"scene" : preload("res://regions/thayma/rooms/thayma_throne_room.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "thayma",
		"challenge" : true,
	},
	#endregion
	#region aporia
	"aporia_room_0" : {
		"scene" : preload("res://regions/aporia/rooms/aporia_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "aporia",
	},
	#endregion
	#region olethros
	"olethros_room_0" : {
		"scene" : preload("res://regions/olethros/rooms/olethros_room_0.tscn"), 
		"zoom_scale" : 0.9, 
		"region" : "olethros",
	},
	#endregion
}

var entity_data = {
	#region vasis
	"leaper" : {
		"scene" : preload("res://regions/vasis/leaper/leaper.tscn")
	},
	"spitter" : {
		"scene" : preload("res://regions/vasis/spitter/spitter.tscn")
	},
	"giga_leaper" : {
		"scene" : preload("res://regions/vasis/giga_leaper/giga_leaper.tscn")
	},
	"giga_spitter" : {
		"scene" : preload("res://regions/vasis/giga_spitter/giga_spitter.tscn")
	},
	#endregion
	#region thayma
	"breaker" : {
		"scene" : preload("res://regions/thayma/breaker/breaker.tscn")
	},
	"mars" : {
		"scene" : preload("res://regions/thayma/mars/mars.tscn")
	},
	"trispitter" : {
		"scene" : preload("res://regions/thayma/trispitter/trispitter.tscn")
	},
	"saturn" : {
		"scene" : preload("res://regions/thayma/saturn/saturn.tscn")
	},
	#endregion
	#region aporia
	"mold" : {
		"scene" : preload("res://regions/aporia/mold/mold.tscn")
	},
	"leaker" : {
		"scene" : preload("res://regions/aporia/leaker/leaker.tscn")
	},
	"spitball" : {
		"scene" : preload("res://regions/aporia/spitball/spitball.tscn")
	},
	"mold_mother" : {
		"scene" : preload("res://regions/aporia/mold_mother/mold_mother.tscn")
	},
	#endregion
	#region olethros
	"griefer" : {
		"scene" : preload("res://regions/olethros/griefer/griefer.tscn")
	},
	"rocketjumper" : {
		"scene" : preload("res://regions/olethros/rocketjumper/rocketjumper.tscn")
	},
	"meteor" : {
		"scene" : preload("res://regions/olethros/meteor/meteor.tscn")
	},
	"hydra" : {
		"scene" : preload("res://regions/olethros/hydra/hydra.tscn")
	},
	"harbinger" : {
		"scene" : preload("res://regions/olethros/harbinger/harbinger.tscn")
	},
	#endregion
}
