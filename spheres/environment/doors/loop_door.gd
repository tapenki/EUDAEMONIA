extends Door

func enter():
	get_node("/root/Main").loop += 1
	super()
