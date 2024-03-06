extends IdleState

func physics_update(delta):
	super(delta)
	if Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf"):
		switch_state.emit(helper.surf_state)

func _input(event):
	if !active:
		return
	#if event.is_action("surf") or event.is_action("jsurf"):
		#switch_state.emit(helper.surf_state)
