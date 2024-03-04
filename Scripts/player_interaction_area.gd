class_name Player
extends Area2D

var in_mech_area: bool = false

signal bubble_entered(area)

func _on_area_entered(area):
	if area is Mech:
		in_mech_area = true
	if area is Bubble:
		bubble_entered.emit(area)


func _on_area_exited(area):
	if area is Mech:
		in_mech_area = false
