extends Area2D
signal jam_grabbed

func _ready():
	pass

func _on_Jam_area_entered(area):
	if area.get_name() == "bread":
		emit_signal("jam_grabbed")
		queue_free()