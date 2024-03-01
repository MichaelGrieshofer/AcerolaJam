extends IdleState

func physics_update(delta):
	super(delta)
	if Input.is_action_pressed("surf"):
		switch_state.emit(helper.surf_state)

