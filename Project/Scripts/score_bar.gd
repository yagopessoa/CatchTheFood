extends Node2D

const pos_ini = Vector2(-18, -5)
const max_pos = 19
const grow_factor = 0.4
const ini_size = Vector2(2, 4)
var size = Vector2(2, 4)
export var bar_color = Color(37.34, 2.24, 114.55)
var emissors
var emissors_ini_pos

func _ready():
	emissors = get_node("emissors")
	emissors_ini_pos = emissors.get_pos()

func grow():
	if size.x < max_pos:
		var pos = emissors.get_pos()
		pos.x += grow_factor
		emissors.set_pos(pos)
		size.x += grow_factor
		update()
		return false
	else:
		size = ini_size
		emissors.set_pos(emissors_ini_pos)
		update()
		return true

func _draw():
	var retang = Rect2(pos_ini, size)
	draw_rect(retang, bar_color)