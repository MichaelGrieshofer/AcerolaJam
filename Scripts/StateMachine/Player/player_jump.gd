extends JumpState


@export var from_wall: bool = false
@export var dive_kick_cancelable: bool = true
@export var horizontal_speed: float = 80
@export var surf: bool = false


func enter_state():
	super()
	if from_wall:
		actor.velocity.x = -horizontal_speed*helper.look_dir
	if surf:
		helper.toggle_after_image(true)


func exit_state():
	super()
	helper.toggle_after_image(false)


func physics_update(delta):
	actor.velocity.y += gravity * delta
	if actor.velocity.y >= 0:
		if (Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf")) and surf:
			switch_state.emit(helper.surf_fall_state)
		else:
			switch_state.emit(helper.fall_state)
	if actor.is_on_wall():
		if (Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf")) and Save.check_for_ability("res://Resources/CustomResources/Abilities/wall_surf.tres"):
			switch_state.emit(helper.wall_surf_state)
	air_control()
	actor.move_and_slide()


func _input(event):
	super(event)
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
	if event.is_action_pressed("divekick") or event.is_action_pressed("jdivekick"):
		#DiveKick
		if Save.check_for_ability("res://Resources/CustomResources/Abilities/divekick.tres"):
			switch_state.emit(helper.dive_kick_state)
