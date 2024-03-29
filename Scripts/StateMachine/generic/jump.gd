class_name JumpState
extends State

@export var jump_height: float = 200
@export var gravity: float = 500
@export var jump_cancel_reduction: float = 0.25
@export var acceleration: float = 0.05
@export var speed: float = 90


func enter_state():
	super()
	helper.ct.stop()
	actor.velocity.y = -jump_height


func physics_update(delta):
	actor.velocity.y += gravity * delta
	if actor.velocity.y >= 0:
		switch_state.emit(helper.fall_state)
	air_control()
	actor.move_and_slide()


func _input(event):
	if !active:
		return
	if event.is_action_released("jump") or event.is_action_released("jboost"):
		jump_cancel()


func jump_cancel():
	if !actor.velocity.y > 0:
		actor.velocity.y = actor.velocity.y*jump_cancel_reduction


func air_control():
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.dir,acceleration)
