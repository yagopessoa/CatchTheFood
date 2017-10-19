extends AnimatedSprite

var lives = 6
var is_dead = false

func _ready():
	get_child(1).hide()
	get_child(2).hide()

func lose_life():
	if lives > 1:
		get_child(3).stop_all()
		get_child(3).play("buzzer")

	if lives == 6:
		get_child(0).play("lives_25")
		lives -= 1
	elif lives == 5:
		get_child(0).play("lives_2")
		lives -= 1
	elif lives == 4:
		get_child(0).play("lives_15")
		lives -= 1
	elif lives == 3:
		get_child(0).play("lives_1")
		lives -= 1
	elif lives == 2:
		get_child(0).play("lives_05")
		lives -= 1
	else:
		get_child(0).play("lives_0")
		lives -= 1
		var spawner = get_parent().get_parent().get_child(7)
		spawner.stop_falling()
		is_dead = true
		get_child(1).show()
		get_child(2).show()
		get_parent().get_parent().get_child(1).stop()
		get_child(3).play("fail")
		
		#delete all foods after dying
		for child in get_parent().get_parent().get_child(7).get_children():
			child.queue_free()

func is_alive():
	return not is_dead

func restart_lives():
	lives = 6
	get_child(0).play("lives_3")
	is_dead = false

func die():
	lives = 0
	get_child(0).play("lives_0")
	is_dead = true
	get_child(1).show()
	get_child(2).show()
	get_parent().get_parent().get_child(1).stop()
	get_child(3).play("fail")
	
	#delete all foods after dying
	for child in get_parent().get_parent().get_child(7).get_children():
		child.queue_free()

func stop_sound():
	if is_alive():
		get_child(3).stop_all()