extends IdleState


func physics_update(delta):
	if helper.dir == 0:
		actor.velocity.x = lerp(actor.velocity.x,0.0,deceleration)
	if helper.dir != 0:
		switch_state.emit(helper.walk_state)
	helper.check_for_fall()
	check_for_jump()
	actor.move_and_slide()
	
	if (Input.is_action_just_pressed("dash") or Input.is_action_just_pressed("jdash")):
		if helper.piloted and helper.water.current_hp > 0 and Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_dash.tres"):
			switch_state.emit(helper.dash_state)


func check_for_jump():
	if helper.ib.time_left > 0 and (Input.is_action_pressed("jump") or Input.is_action_pressed("jboost")):
		helper.ib.stop()
		helper.state_machine.change_state(helper.jump_state)
