class_name Player
extends Area2D

var in_mech_area: bool = false
var in_inside_area: bool = false

signal bubble_entered(area)

func _on_area_entered(area):
	if area is Mech:
		in_mech_area = true
	if area is Bubble:
		bubble_entered.emit(area)
	if area.is_in_group("Inside"):
		in_inside_area = true
		GameManager.player_inside = true
	if area is Checkpoint:
		Transition.last_checkpoint_pos = area.spawn_location


func _on_area_exited(area):
	if area is Mech:
		in_mech_area = false
	if area.is_in_group("Inside"):
		in_inside_area = false
		GameManager.player_inside = false
