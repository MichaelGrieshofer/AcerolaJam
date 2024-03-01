extends FallState

func physics_update(delta):
	super(delta)
	if Input.is_action_just_pressed("jump") and helper.ct.time_left == 0:
		switch_state.emit(helper.hover_state)
