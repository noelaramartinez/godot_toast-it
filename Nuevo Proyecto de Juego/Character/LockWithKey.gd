extends Area2D
signal lock_with_key_grabbed

func _ready():
	pass


func _on_LockWithKey_area_entered(area):
	if area.get_name() == "bread":
		emit_signal("lock_with_key_grabbed")
		#call_deferred("lock_with_key_grabbed")
		queue_free()
