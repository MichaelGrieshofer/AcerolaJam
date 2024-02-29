class_name Player
extends Area2D

var in_mech_area: bool = false

func _on_area_entered(area):
	if area is Mech:
		in_mech_area = true


func _on_area_exited(area):
	if area is Mech:
		in_mech_area = false
