extends WalkState

func physics_update(delta):
	super(delta)
	if Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf"):
		if actor.is_on_wall() and Save.check_for_ability("res://Resources/CustomResources/Abilities/wall_surf.tres"):
			switch_state.emit(helper.wall_surf_state)
		else:
			if Save.check_for_ability("res://Resources/CustomResources/Abilities/surf.tres"):
				switch_state.emit(helper.surf_state)
