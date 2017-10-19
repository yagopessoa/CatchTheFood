extends Node2D

var speed = 50.0
var exploded = false

var explosion

func _ready():
	set_process(true)

func filter_food():
	get_child(0).remove_child(get_child(0).get_child(4))
	randomize()
	var random = randi()%4+0
	get_child(0).remove_child(get_child(0).get_child(random))
	randomize()
	random = randi()%3+0
	get_child(0).remove_child(get_child(0).get_child(random))
	randomize()
	random = randi()%2+0
	get_child(0).remove_child(get_child(0).get_child(random))

func get_special():
	get_child(0).remove_child(get_child(0).get_child(0))
	get_child(0).remove_child(get_child(0).get_child(0))
	get_child(0).remove_child(get_child(0).get_child(0))
	get_child(0).remove_child(get_child(0).get_child(0))

func _process(deltatime):
	var pos = get_child(0).get_child(0).get_pos()
	pos.y += speed * deltatime
	get_child(0).get_child(0).set_pos(pos)

func get_score():
	var kind = get_child(0).get_child(0).get_name()
	#print(kind)
	
	if kind == "fries":
		return 5
	elif kind == "icecream":
		return 10
	elif kind == "pizza":
		return 15
	elif kind == "hamburger":
		return 25
	elif kind == "special":
		return 50

func can_eat():
	return not exploded

func explode():
	exploded = true
	get_child(0).get_child(0).get_child(0).play("desapear")
	get_child(0).get_child(0).get_child(1).queue_free()
	get_child(0).get_child(0).get_child(2).show()
	get_child(0).get_child(0).get_child(2).get_child(0).play("explode")