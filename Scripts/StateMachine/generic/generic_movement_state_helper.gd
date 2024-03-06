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
var last_dir: float = 1
var look_dir: float = 1

func _physics_process(delta):
	get_direction()
	set_body_look_direction()
	if actor.is_on_floor():
		ct.start()
	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("jjump"):
		ib.start()


func get_direction():
	dir = Input.get_axis("left","right")
	var controller_dir = Input.get_axis("jleft","jright")
	dir = dir+controller_dir
	dir = clamp(dir,-1,1)
	if dir != 0:
		last_dir = dir
	else:
		last_dir = look_dir


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
	if ib.time_left > 0 and (Input.is_action_pressed("jump") or Input.is_action_pressed("jjump")):
		ib.stop()
		state_machine.change_state(jump_state)
