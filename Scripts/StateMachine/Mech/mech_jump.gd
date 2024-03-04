extends JumpState

func physics_update(delta):
	super(delta)
	if (Input.is_action_just_pressed("dash") or Input.is_action_just_pressed("jdash")) and helper.piloted:
		switch_state.emit(helper.dash_state)
