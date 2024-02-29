extends State

@export var deceleration: float = 0.2

func physics_update(delta):
	actor.velocity.x = lerp(actor.velocity.x,0.0,deceleration)
	if helper.dir != 0:
		switch_state.emit(helper.walk_state)
	helper.check_for_fall()
	helper.check_for_jump()
	actor.move_and_slide()
