extends FallState

func physics_update(delta):
	actor.velocity.y += gravity * delta
	if helper.ct.time_left > 0 and helper.ib.time_left > 0 and (Input.is_action_pressed("jump") or Input.is_action_pressed("jboost")):
		switch_state.emit(helper.jump_state)
	if actor.velocity.y >= max_fall_speed:
		actor.velocity.y = max_fall_speed
	air_control()
	check_for_landing()
	actor.move_and_slide()
	
	if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("jboost")) and helper.ct.time_left == 0 and helper.piloted:
		switch_state.emit(helper.hover_state)
	
	if (Input.is_action_just_pressed("dash") or Input.is_action_just_pressed("jdash")) and helper.piloted and helper.water.current_hp > 0:
		switch_state.emit(helper.dash_state)
