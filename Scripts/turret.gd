extends Node2D

@export var rotation_clamp: float = 90

@onready var state_machine = $FiniteStateMachine
@onready var rot: = $RotationPoint

@onready var idle: State = $FiniteStateMachine/Idle
@onready var aim: State = $FiniteStateMachine/Aim
@onready var shoot: State = $FiniteStateMachine/Shoot

@export var aim_confirm_time: float = 0.5
@export var bullet_salve: int = 20
@export var aim_speed: float = 0.03
@export var time_between_shots: float = 0.05
@export var reload_speed: float = 0.3


var mech_target = false
var player_target = false


func _on_area_2d_area_entered(area):
	if area is Mech:
		mech_target = true
		state_machine.change_state(aim)
	if area is Player:
		player_target = true
		state_machine.change_state(aim)


func _on_area_2d_area_exited(area):
	if area is Mech:
		mech_target = false
		state_machine.change_state(idle)
	if area is Player:
		player_target = false
		state_machine.change_state(idle)
