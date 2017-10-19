extends Node

var player
var last_h_axis = 0

var speed = 50.0
var heading_dir = 0.0
var anim

var FoodType = preload("res://Scripts/food.gd")
var score = 0
const MAX_SEQ = 50
var sequence_count = 0

var bonus_ms = false
var bonus_count = 0.0
var multiplier = 1
var multiplier_count = 0.0

var bar_anim
var timeElapsed = 0.0
var frame_count = 0

func _ready():
	get_child(4).hide()
	get_child(5).hide()
	player = get_node("../player")
	anim = get_node("../player/anim")
	bar_anim = get_child(6).get_child(0)
	set_process(true)
	
func _process(deltatime):
	#checking double points
	if multiplier == 2:
		multiplier_count += deltatime
		if multiplier_count > 12:
			multiplier = 1
			multiplier_count = 0.0
			get_child(4).hide()
			get_child(7).show()
	
	#checking position
	var pos = player.get_pos()
	if bonus_ms:
		bonus_count += deltatime
		if bonus_count < 8.0:
			pos.x += speed * deltatime * heading_dir * 2
		else:
			#get_child(1).stop_all()
			bonus_ms = false
			bonus_count = 0.0
			get_child(5).hide()
	else:
		pos.x += speed * deltatime * heading_dir
	pos = bound_pos(pos)
	player.set_pos(pos)
	
	var h_axis = get_h_axis()
	
	if last_h_axis != h_axis:
		if get_parent().get_child(4).get_child(1).is_alive():
			if get_parent().get_child(7).has_started():
				move_player(h_axis)
		
	last_h_axis = h_axis
	
	#catching things
	var things = player.get_child(1).get_overlapping_bodies()
	if things.size() != 0:
		for thing in things:
			if FoodType.instance_has(thing.get_parent().get_parent().get_parent()):
				if get_parent().get_child(4).get_child(1).is_alive():
					eat_food(thing.get_parent().get_parent().get_parent())

func get_h_axis():
	var h_axis = 0	
	if Input.is_action_pressed("player_left"):
		h_axis -= 1
	if Input.is_action_pressed("player_right"):
		h_axis += 1
	return h_axis

func move_player(h_axis):
	if h_axis > 0:
		go_right()
	elif h_axis < 0:
		go_left()
	else:
		stop()

# --> Char controller API
func go_left():
	player.set_flip_h(false)
	anim.play("walk")
	heading_dir = -1.0

func go_right():
	player.set_flip_h(true)
	anim.play("walk")
	heading_dir = 1.0
	
func stop():
	anim.play("idle")
	heading_dir = 0.0
	
func bound_pos(pos):
	if pos.x > 152:
		pos.x = 152
	if pos.x < 38:
		pos.x = 38
	return pos

# --> Score controller
func eat_food(food):
	if food.can_eat():
		
		if multiplier != 2:
				if get_child(7).grow():
					get_child(7).hide()
					get_child(4).show()
					get_parent().get_child(9).play("double")
					multiplier = 2
		
		score += food.get_score() * multiplier
		if food.get_child(0).get_child(0).get_name() == "special":
			bonus_ms = true
			get_child(1).play("special")
			get_child(5).show()
		else:
			get_child(1).play("snack")
		get_child(0).set_text(str(score))
		
		food.explode()

func restart_score():
	score = 0
	get_child(0).set_text(str(score))
	sequence_count = 0
	get_child(3).set_text(str(sequence_count))
	bonus_ms = false
	bonus_count = 0
	multiplier = 1
	multiplier_count = 0
	get_child(4).hide()
	get_child(5).hide()

func get_score():
	return score

func reset_sequence():
	sequence_count = 0

func reset_bar():
	bar_anim.play("0")
	frame_count = 0