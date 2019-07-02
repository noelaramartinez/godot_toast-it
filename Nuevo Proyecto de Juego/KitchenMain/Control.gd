extends Control

var color = Color(1.0,1.0,1.0)
var initP = Vector2()
var endP = Vector2()
var normal = 100


#vector final es la interrogante
#la condición es que el vector que se forma entre end e ini tenga una normal igual a 100
#10^2 = sqr((ini.x-end.x)^2 + (ini.y-end.y)^2)
#end.x = ini.x- sqr(100 - (ini.y-end.y)^2)
#end.y = ini.y- sqr(100 - (ini.x-end.x)^2)

func _draw():
	color = Color(.2,.8,.7)
	var ini = initP
	var end = endP
	draw_line(ini, end, color)

func _process(delta):
	update()

