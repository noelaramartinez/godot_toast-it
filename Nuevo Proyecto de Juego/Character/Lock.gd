extends Area2D
signal lock_grabbed

func _ready():
	pass

func _on_Lock_area_entered(area):
	if area.get_name() == "bread":
		emit_signal("lock_grabbed")
		#queue_free()
