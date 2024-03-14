extends Node

var mech_position: Vector2 = Vector2.ZERO
var player_position: Vector2 = Vector2.ZERO
var player_outside_mech: bool = true
var remote_control: bool = false
var cannot_remote_control: bool = false
var controller: bool = false
var player_inside: bool = false

func _input(event):
	if event is InputEventMouseButton or event is InputEventKey:
		controller = false
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		controller = true
