extends State

func enter_state():
	super()
	if actor.player_target or actor.mech_target:
		switch_state.emit(actor.aim)
