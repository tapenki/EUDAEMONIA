extends Projectile

func on_collision(crits: int):
	if hit_particles:
		get_node("/root/Main").spawn_particles(get_node("/root/Main/Particles/" + hit_particles), 12, global_position, scale.x, get_node("Sprite").self_modulate)
	if crits > 0 and crit_particles:
		get_node("/root/Main").spawn_particles(get_node("/root/Main/Particles/" + crit_particles), 6, global_position, scale.x, get_node("Sprite").self_modulate)
	if hit_sound:
		get_node("/root/Main").play_sound(hit_sound)
