extends WalkState

func physics_update(delta):
	super(delta)
	if Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf"):
		if actor.is_on_wall():
			switch_state.emit(helper.wall_surf_state)
		else:
			switch_state.emit(helper.surf_state)
