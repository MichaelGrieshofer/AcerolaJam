extends IdleState

func physics_update(delta):
	super(delta)
	if Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf"):
		if Save.check_for_ability("res://Resources/CustomResources/Abilities/surf.tres"):
			switch_state.emit(helper.surf_state)

func _input(event):
	if !active:
		return
