extends WalkState


func enter_state():
	super()
	helper.toggle_after_image(true)


func exit_state():
	helper.toggle_after_image(false)


func physics_update(delta):
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.last_dir,acceleration)
	
	if Input.is_action_just_released("surf") or Input.is_action_just_released("jsurf"):
		switch_state.emit(helper.idle_state)
	
	if actor.is_on_wall() and (Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf")):
		switch_state.emit(helper.wall_surf_state)
	
	if !actor.is_on_floor():
		switch_state.emit(helper.surf_fall_state)
	
	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("jjump"):
		switch_state.emit(helper.surf_jump_state)
	
	actor.move_and_slide()


func air_control():
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.look_dir,acceleration)
