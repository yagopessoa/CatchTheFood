extends AnimatedSprite

func explode_parent():
	get_parent().get_parent().get_parent().queue_free()