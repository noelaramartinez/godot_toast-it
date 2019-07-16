extends Node2D

func _ready():
	pass

func generateJamJar():
	return get_child(0).duplicate()

func generateLock():
	return get_child(1).duplicate()

func generateLockWithKey():
	return get_child(2).duplicate()

func generateOpenDoor():
	return get_child(3).duplicate()