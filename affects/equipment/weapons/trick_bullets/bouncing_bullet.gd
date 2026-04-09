extends Projectile

func wall_collision():
	if hit_walls:
		for body in get_overlapping_bodies():
			if body is TileMapLayer:
				on_collision(0)
