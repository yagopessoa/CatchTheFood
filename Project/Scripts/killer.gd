extends Area2D

func _ready():
	set_process(true)

func _process(deltatime):
	var things = get_overlapping_bodies()
	for thing in things:
		thing.queue_free()  # KILL
		var lives = get_node("../right_menu/lives")
		if lives.is_alive():
			var sky = get_node("../environment/sky/anim")
			sky.play("sky_blink")
			lives.lose_life()