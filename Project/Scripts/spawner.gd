extends Node2D

var food
var timer = 0.0
var fall = false
var start = false
var start_timer = 0.0
var time_between = 1.4
var count = 0

func _ready():
	set_process(true)

func spawn_food():
	count += 1
	var food_scn = preload("res://Scenes/food.scn")
	food = food_scn.instance()
	if count < 20:
		food.filter_food()
	else:
		food.get_special()
		count = 0
	var random = randi()%95+55
	food.get_child(0).get_child(0).set_pos(Vector2(random, -10))
	add_child(food)

func _process(deltatime):
	if Input.is_action_pressed("player_exit"):
			start = false
			get_parent().get_parent().get_child(1).show() #exit screen
			get_parent().get_parent().get_child(0).queue_free()

	if start:
		if get_parent().get_child(1).get_score() > 4000:
			time_between = 0.6
		elif get_parent().get_child(1).get_score() > 3000:
			time_between = 0.8
		elif get_parent().get_child(1).get_score() > 2000:
			time_between = 1.0
		elif get_parent().get_child(1).get_score() > 800:
			time_between = 1.2
		
		start_timer += deltatime
		timer += deltatime
		if !fall:
			spawn_food()
			fall = true
	
		if timer > time_between:
			timer = 0.0
			fall = false
	else:
		if Input.is_action_pressed("player_start"):
			if get_child_count() > 0:
				get_child(0).hide()
			start = true
			start_timer = 0.0
			get_parent().get_child(1).restart_score()
			get_parent().get_child(4).get_child(1).get_child(1).hide()
			get_parent().get_child(4).get_child(1).get_child(2).hide()
			get_parent().get_child(4).get_child(1).restart_lives()
			var pos = get_parent().get_child(2).get_pos()
			pos.x = 100
			get_parent().get_child(2).set_pos(pos)
			
			#reseting sequence bar
			get_parent().get_child(1).reset_bar()

func has_started():
	return start

func stop_falling():
	start = false

func start_falling():
	start = true