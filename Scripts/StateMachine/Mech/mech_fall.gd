extends FallState

func physics_update(delta):
	super(delta)
	if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("jboost")) and helper.ct.time_left == 0 and helper.piloted:
		switch_state.emit(helper.hover_state)
	
	if (Input.is_action_just_pressed("dash") or Input.is_action_just_pressed("jdash")) and helper.piloted and helper.water.current_hp > 0:
		switch_state.emit(helper.dash_state)
