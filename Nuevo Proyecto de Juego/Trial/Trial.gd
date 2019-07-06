extends Line2D

var point
var target
var draw = true
export(NodePath) var targetPath

func _ready():
	target = get_node("..")
	#print(targetPath)
	#print("tar: ",target)

func _process(delta):
	var d =  delta+1
	d = d+1
	global_position = Vector2(0,0)
	global_rotation = 0
	point = target.global_position
	if(draw):
		add_point(point)

func setDraw(val):
	draw = val

func set_target_node():
	target = get_node(targetPath)

