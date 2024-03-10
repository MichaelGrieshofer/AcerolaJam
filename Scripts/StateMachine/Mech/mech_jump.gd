extends JumpState

func physics_update(delta):
	super(delta)
	if (Input.is_action_just_pressed("dash") or Input.is_action_just_pressed("jdash")):
		if (helper.piloted or GameManager.remote_control) and helper.water.current_hp > 0 and Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_dash.tres"):
			switch_state.emit(helper.dash_state)
	
	if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("jboost")):
		if helper.ct.time_left == 0 and (helper.piloted or GameManager.remote_control) and Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_hover.tres"):
			switch_state.emit(helper.hover_state)
