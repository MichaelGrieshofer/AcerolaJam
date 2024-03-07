extends WalkState


func physics_update(delta):
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.dir,acceleration)
	if helper.dir == 0:
		switch_state.emit(helper.idle_state)
	helper.check_for_fall()
	check_for_jump()
	actor.move_and_slide()
	anim.speed_scale = (actor.velocity.x/speed)*2 * helper.look_dir
	if abs(anim.speed_scale) < 0.3:
		if anim.speed_scale < 0:
			anim.speed_scale = -0.3
		elif anim.speed_scale >= 0:
			anim.speed_scale = 0.3
	anim.speed_scale = clamp(anim.speed_scale,-1,1)
	
	if (Input.is_action_just_pressed("dash") or Input.is_action_just_pressed("jdash")):
		if helper.piloted and helper.water.current_hp > 0 and Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_dash.tres"):
			switch_state.emit(helper.dash_state)


func exit_state():
	super()
	anim.speed_scale = 1


func check_for_jump():
	if helper.ib.time_left > 0 and (Input.is_action_pressed("jump") or Input.is_action_pressed("jboost")):
		helper.ib.stop()
		helper.state_machine.change_state(helper.jump_state)
