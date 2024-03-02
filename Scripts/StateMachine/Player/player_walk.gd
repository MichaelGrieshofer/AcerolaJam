extends WalkState

func physics_update(delta):
	super(delta)
	if Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf"):
		switch_state.emit(helper.surf_state)
	if actor.is_on_wall() and (Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf")):
		switch_state.emit(helper.wall_surf_state)
