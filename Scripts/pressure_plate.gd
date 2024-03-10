class_name PressurePlate
extends Node2D


signal mech_exited
signal mech_entered

var mech_inside: bool = false

@onready var sprite: Sprite2D = $Buttons


func _on_area_2d_area_entered(area):
	if area is Mech:
		sprite.frame = 1
		mech_inside = true
		mech_entered.emit()


func _on_area_2d_area_exited(area):
	if area is Mech:
		sprite.frame = 0
		mech_inside = false
		mech_exited.emit()
