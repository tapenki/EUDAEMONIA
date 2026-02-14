class_name ParticleSpriteProjectile extends Projectile

func get_sprites():
	var sprite = get_node("Sprite")
	return [{"node" : sprite, "size" : sprite.texture.get_size(), "position" : sprite.position, "offset" : Vector2()}]
