extends Sprite

func _ready():
	set_process(true)

func _process(deltatime):
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()
	elif Input.is_action_pressed("return_to_game"):
		get_tree().change_scene("res://Scenes/level_1.tscn")