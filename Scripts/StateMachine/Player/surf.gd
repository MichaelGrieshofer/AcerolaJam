extends WalkState


func enter_state():
	super()
	helper.toggle_after_image(true)


func exit_state():
	super()
	helper.toggle_after_image(false)


func physics_update(delta):
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.last_dir,acceleration)
	
	if !actor.is_on_floor():
		switch_state.emit(helper.surf_fall_state)
	
	if actor.is_on_wall():
		if Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf"):
			switch_state.emit(helper.wall_surf_state)
	
	actor.move_and_slide()


func air_control():
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.look_dir,acceleration)


func _input(event):
	if !active:
		return
	if event.is_action_released("surf") or event.is_action_released("jsurf"):
		switch_state.emit(helper.idle_state)
	#if event.is_action("surf") or event.is_action("jsurf"):
		#if actor.is_on_wall():
			#switch_state.emit(helper.wall_surf_state)
	if event.is_action_pressed("jump") or event.is_action_pressed("jjump"):
		switch_state.emit(helper.surf_jump_state)
