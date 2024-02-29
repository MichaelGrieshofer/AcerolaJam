class_name GenericMovementStateHelper
extends StateHelper

@export var ct: Timer
@export var ib: Timer

@export var idle_state: State
@export var walk_state: State
@export var fall_state: State
@export var jump_state: State

var dir: float = 0

signal jump_cancel

func _physics_process(delta):
	get_direction()
	if actor.is_on_floor():
		ct.start()
	if Input.is_action_just_pressed("jump"):
		ib.start()
	if Input.is_action_just_released("jump"):
		jump_cancel.emit()


func get_direction():
	dir = Input.get_axis("left","right")


func check_for_fall():
	if !actor.is_on_floor():
		state_machine.change_state(fall_state)


func check_for_jump():
	if ib.time_left > 0:
		ib.stop()
		state_machine.change_state(jump_state)
