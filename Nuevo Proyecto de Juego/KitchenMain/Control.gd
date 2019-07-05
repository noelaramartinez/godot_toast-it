extends Control

var color = Color(1.0,1.0,1.0)
var initP = Vector2()
var endP = Vector2()
var normal = 100

#obtener el vector unitario en la dirección actual y multiplicarlo por 100, luego obtetner la suma del origen con ese vector 
#y se obtine el vectro para 'end' máximo

func _draw():
	color = Color(.4,1,.4)
	var ini = initP
	var end = endP
	var normaControl = sqrt(pow(abs(end.x-ini.x),2) + pow(abs(end.y-ini.y),2))
	if normaControl>100:
		var aux = end - ini
		aux = aux.normalized()*100
		end = ini + aux
	draw_line(ini, end, color)

func _process(delta):
	update()

func drawLine():
	_draw()