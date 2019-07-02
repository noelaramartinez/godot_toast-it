extends Area2D

#var init_position = Vector2()
#var init_angle
signal butter_grabbed

func reset_position():
	pass

func _on_Butter_area_entered(area):
	if area.get_name() == "bread":
		emit_signal("butter_grabbed")
		queue_free()

