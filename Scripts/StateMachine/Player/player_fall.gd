extends FallState

@export var surf: bool = false

func enter_state():
	super()
	if surf:
		%Surf.play()
		helper.toggle_after_image(true)


func exit_state():
	super()
	if surf:
		%Surf.stop()
		helper.toggle_after_image(false)

func physics_update(delta):
	actor.velocity.y += gravity * delta
	if actor.velocity.y >= max_fall_speed:
		actor.velocity.y = max_fall_speed
	
	if helper.ct.time_left > 0 and helper.ib.time_left > 0:
		if (Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf")) and surf and Save.check_for_ability("res://Resources/CustomResources/Abilities/surf.tres"):
			switch_state.emit(helper.surf_jump_state)
		else:
			switch_state.emit(helper.jump_state)
	
	if actor.is_on_wall():
		if (Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf")) and Save.check_for_ability("res://Resources/CustomResources/Abilities/wall_surf.tres"):
			switch_state.emit(helper.wall_surf_state)
	
	air_control()
	check_for_landing()
	actor.move_and_slide()

func air_control():
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.dir,acceleration)


func _input(event):
	if !active:
		return
	if event.is_action_pressed("jump") or event.is_action_pressed("jjump"):
		#DoublJump
		if Save.check_for_ability("res://Resources/CustomResources/Abilities/double_jump.tres") and helper.has_double_jump and helper.ct.time_left == 0:
			helper.has_double_jump = false
			if (Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf")) and surf:
				switch_state.emit(helper.surf_double_jump_state)
			else:
				switch_state.emit(helper.double_jump_state)
	if (event.is_action_released("surf") or event.is_action_released("jsurf")):
		#Fall
		if surf:
			switch_state.emit(helper.fall_state)
	if event.is_action_pressed("divekick") or event.is_action_pressed("jdivekick"):
		#DiveKick
		if Save.check_for_ability("res://Resources/CustomResources/Abilities/divekick.tres"):
			switch_state.emit(helper.dive_kick_state)


func check_for_landing():
	if actor.is_on_floor():
		switch_state.emit(helper.idle_state)
		%Landing.play()
