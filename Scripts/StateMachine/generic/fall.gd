extends State

@export var gravity: float = 500
@export var acceleration: float = 0.05
@export var speed: float = 90


func physics_update(delta):
	actor.velocity.y += gravity * delta
	if helper.ct.time_left > 0 and helper.ib.time_left > 0:
		helper.ct.stop()
		switch_state.emit(helper.jump_state)
	air_control()
	check_for_landing()
	actor.move_and_slide()


func check_for_landing():
		if actor.is_on_floor():
			switch_state.emit(helper.idle_state)


func air_control():
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.dir,acceleration)
