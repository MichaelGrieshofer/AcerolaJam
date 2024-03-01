class_name GenericMovementStateHelper
extends StateHelper

@export var ct: Timer
@export var ib: Timer

@export var body: Node2D

@export var idle_state: State
@export var walk_state: State
@export var fall_state: State
@export var jump_state: State

var dir: float = 0
var look_dir: float = 1

signal jump_cancel
signal jump

func _physics_process(delta):
	get_direction()
	set_body_look_direction()
	if actor.is_on_floor():
		ct.start()
	if Input.is_action_just_pressed("jump"):
		ib.start()
		jump.emit()
	if Input.is_action_just_released("jump"):
		jump_cancel.emit()


func get_direction():
	dir = Input.get_axis("left","right")


func set_body_look_direction():
	if actor.velocity.x > 0: 
		look_dir = 1
	elif actor.velocity.x < 0:
		look_dir = -1
	body.scale.x = look_dir


func check_for_fall():
	if !actor.is_on_floor():
		state_machine.change_state(fall_state)


func check_for_jump():
	if ib.time_left > 0:
		ib.stop()
		state_machine.change_state(jump_state)
