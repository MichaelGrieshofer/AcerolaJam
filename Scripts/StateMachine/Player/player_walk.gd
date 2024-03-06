extends WalkState


func _input(event):
	if !active:
		return
	if event.is_action("surf") or event.is_action("jsurf"):
		if actor.is_on_wall():
			switch_state.emit(helper.wall_surf_state)
		else:
			switch_state.emit(helper.surf_state)
