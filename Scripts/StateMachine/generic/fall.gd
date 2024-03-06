class_name FallState
extends State

@export var gravity: float = 500
@export var max_fall_speed: float = 300
@export var acceleration: float = 0.05
@export var speed: float = 90


func physics_update(delta):
	actor.velocity.y += gravity * delta
	if helper.ct.time_left > 0 and helper.ib.time_left > 0 and (Input.is_action_pressed("jump") or Input.is_action_pressed("jjump")):
		switch_state.emit(helper.jump_state)
	if actor.velocity.y >= max_fall_speed:
		actor.velocity.y = max_fall_speed
	air_control()
	check_for_landing()
	actor.move_and_slide()


func check_for_landing():
		if actor.is_on_floor():
			switch_state.emit(helper.idle_state)


func air_control():
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.dir,acceleration)
