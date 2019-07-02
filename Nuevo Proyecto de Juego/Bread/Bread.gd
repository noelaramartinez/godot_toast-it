extends Node2D

#var init_position = Vector2()
#var init_angle
#var dragging 
#var drag_start = Vector2()

func _ready():
	pass

func start(pos):
	position = pos

func my_rotate(rads):
	#print("rads: ", rads)
	self.rotate(rads)
