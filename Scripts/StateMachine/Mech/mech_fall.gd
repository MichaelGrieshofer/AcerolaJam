extends FallState

func physics_update(delta):
	super(delta)
	if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("jjump")) and helper.ct.time_left == 0 and helper.piloted:
		switch_state.emit(helper.hover_state)
