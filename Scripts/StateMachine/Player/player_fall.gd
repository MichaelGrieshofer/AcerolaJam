extends FallState

@export var surf: bool = false

func enter_state():
	super()
	if surf:
		helper.toggle_after_image(true)


func exit_state():
	if surf:
		helper.toggle_after_image(false)

func physics_update(delta):
	actor.velocity.y += gravity * delta
	if actor.velocity.y >= max_fall_speed:
		actor.velocity.y = max_fall_speed
	air_control()
	check_for_landing()
	actor.move_and_slide()
	
	if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("jjump")) and helper.has_double_jump and helper.ct.time_left == 0:
		helper.has_double_jump = false
		if (Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf")) and surf:
			switch_state.emit(helper.surf_double_jump_state)
		else:
			switch_state.emit(helper.double_jump_state)
	
	if Input.is_action_just_pressed("divekick") or Input.is_action_just_pressed("jdivekick"):
		switch_state.emit(helper.dive_kick_state)
		
	if actor.is_on_wall() and (Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf")):
		switch_state.emit(helper.wall_surf_state)
	
	if surf and (Input.is_action_just_released("surf") or Input.is_action_just_released("jsurf")):
		switch_state.emit(helper.fall_state)
	
	if helper.ct.time_left > 0 and helper.ib.time_left > 0 and (Input.is_action_pressed("jump") or Input.is_action_pressed("jjump")):
		if (Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf")):
			switch_state.emit(helper.surf_jump_state)
		else:
			switch_state.emit(helper.jump_state)

func air_control():
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.dir,acceleration)
