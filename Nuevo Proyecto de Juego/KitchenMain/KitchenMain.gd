extends Node2D

var init_player_position = Vector2(157,447)
var init_angle = 0
var rotate_player = false
var dragging = false
var mouseClickPos = Vector2()
var is_fired = false
var screen_size = Vector2()
var initVelVector = Vector2()

var VecInitPosBread
var VecInitPosToaster
var vectorRef
var vectorNormal
var vectorBase
var vectorRefNormal
var angToRefVectNormal
var theta
var t = 0
var pos_x = 0
var pos_y = 0
var init_vel = 10
var score = 0
var breadSizeMargin = 500
var controlRange = 100

const DEG_1_TO_RAD = 0.01745329252
const gravity = 10
const coef_mov = 3

func _ready():
	$Bread.translate(init_player_position)
	$Toaster.translate(init_player_position)
	screen_size = get_viewport().size
	#print(screen_size)
	VecInitPosBread = Vector2($Bread.get_global_transform().get_origin().x,$Bread.get_global_transform().get_origin().y)
	VecInitPosToaster = Vector2($Toaster.get_global_transform().get_origin().x,$Toaster.get_global_transform().get_origin().y)
	vectorRef = Vector2($Bread.get_global_transform().get_origin().x + 1,$Bread.get_global_transform().get_origin().y)
	vectorRefNormal = Vector2($Bread.get_global_transform().get_origin().x,$Bread.get_global_transform().get_origin().y + 1)
	vectorBase = vectorRef - VecInitPosBread
	vectorNormal =  (VecInitPosBread - vectorRefNormal)
	angToRefVectNormal = vectorNormal.angle_to(vectorBase)
	theta = angToRefVectNormal
	
	for i in range(1,4):
		var butter_scene = preload("res://Butter/Butter.tscn")
		var butter_node = butter_scene.instance()
		if i==1:
			butter_node.translate(Vector2(518,251))
		elif i==2:
			butter_node.translate(Vector2(667,304))
		elif i==3:
			butter_node.translate(Vector2(799,390))
		add_child(butter_node)
		butter_node.connect("butter_grabbed", self, "on_butter_grabbed")

func _input(event):
	if event.is_action_pressed("click") and not dragging and !is_fired:
		dragging = true
	if event.is_action_pressed("click") and dragging and !is_fired:
		mouseClickPos = Vector2(event.position.x, event.position.y)
		rotate_player = true
		initVelVector = mouseClickPos - VecInitPosBread
		var magInitVelVect = clamp(sqrt(initVelVector.x*initVelVector.x + initVelVector.y*initVelVector.y),10,controlRange)
		init_vel = 10 + magInitVelVect/20
	if event is InputEventMouseMotion and !is_fired:
		mouseClickPos = Vector2(event.position.x, event.position.y)
		initVelVector = mouseClickPos - VecInitPosBread
		var magInitVelVect = clamp(sqrt(initVelVector.x*initVelVector.x + initVelVector.y*initVelVector.y),10,controlRange)
		init_vel = 10 + magInitVelVect/20
		var vectorAux = mouseClickPos - init_player_position
		$Control.initP = init_player_position
		$Control.endP = mouseClickPos
		$Control.drawLine()
	if event.is_action_released("click") and dragging and !is_fired:
		dragging = false
		rotate_player = false
		is_fired = true
		hide_previous_trace()
	if $Bread.get_position().x-breadSizeMargin > screen_size.x || $Bread.get_position().y-breadSizeMargin >screen_size.y || $Bread.get_position().x+breadSizeMargin < 0 || $Bread.get_position().y+breadSizeMargin < 0:
		$Bread/Trial.setDraw(false)
		var children = $Bread.get_child($Bread.get_child_count()-1)
		children.setDraw(false)
		reset()

func _physics_process(delta):
	if rotate_player && !is_fired:
		var radianes_a_mover = ($Toaster.get_angle_to(mouseClickPos) - DEG_1_TO_RAD*90 - init_angle) * 0.2
		$Toaster.my_rotate(radianes_a_mover)
		$Bread.my_rotate(radianes_a_mover)
		rotateVectorNormal(radianes_a_mover)
		init_angle = radianes_a_mover
	if is_fired:
		parabolic_movement(delta * coef_mov)

func rotateVectorNormal(radianes_a_mover):
	vectorNormal =  (VecInitPosBread - vectorRefNormal).rotated(radianes_a_mover + PI)
	vectorRefNormal = VecInitPosBread + vectorNormal
	theta = vectorNormal.angle_to(vectorBase) + PI

func parabolic_movement(delta):
	t = t + delta
	pos_x =  init_vel*cos(theta)*t
	pos_y =  init_vel*sin(theta)*t - (gravity*t*t)/2
	$Bread.translate(Vector2(pos_x,-pos_y))

func reset():
	var trail_scn = preload("res://Trial/Trial.tscn")
	var trail_node = trail_scn.instance()
	$Bread.add_child(trail_node)
	var children = $Bread.get_child($Bread.get_child_count()-1)
	children.width = 2
	children.default_color = "#1f667fff"
	$Bread.print_tree_pretty()
	is_fired = false
	$Bread.start(VecInitPosBread)
	pos_x = 0
	pos_y = 0
	t = 0

func on_butter_grabbed():
	score += 10
	$HUD/score_lbl.set_text(str(score))

func hide_previous_trace():
	if $Bread.get_child_count()>2:
		var prevTrace = Line2D
		prevTrace = $Bread.get_child($Bread.get_child_count()-2)
		prevTrace.hide()


