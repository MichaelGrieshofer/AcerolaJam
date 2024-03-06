extends State

@export var downward_speed: float = 200
@export var horizontal_speed: float = 150
@export var dive_into_surf_momentum_loss: float = 0.35


func enter_state():
	super()
	helper.toggle_after_image(true)
	actor.velocity.y = downward_speed
	actor.velocity.x = horizontal_speed * helper.last_dir


func exit_state():
	super()
	helper.toggle_after_image(false)


func physics_update(delta):
	if actor.is_on_floor() or actor.is_on_wall():
		if Input.is_action_pressed("surf") or Input.is_action_pressed("jsurf"):
			#Surf / WallSurf
			if actor.is_on_floor():
				actor.velocity.x *= dive_into_surf_momentum_loss
				switch_state.emit(helper.surf_state)
			elif actor.is_on_wall():
				actor.velocity.x = 0
				switch_state.emit(helper.wall_surf_state)
		else:
			#DiveRebound / walljump
			if actor.is_on_floor():
				switch_state.emit(helper.dive_rebound_state)
			elif actor.is_on_wall(): 
				helper.has_double_jump = true
				switch_state.emit(helper.wall_jump_state)
	actor.move_and_slide()


func _input(event):
	if !active:
		return
	if event.is_action_pressed("jump") or event.is_action_pressed("jjump"):
		#DoublJump
		if Save.check_for_ability("res://Resources/CustomResources/Abilities/double_jump.tres") and helper.has_double_jump and helper.ct.time_left == 0:
			helper.has_double_jump = false
			if (event.is_action("surf") or event.is_action("jsurf")):
				switch_state.emit(helper.surf_double_jump_state)
			else:
				switch_state.emit(helper.double_jump_state)


func _on_interaction_bubble_entered(area):
	if active:
		helper.has_double_jump = true
		area.pop.call_deferred()
		switch_state.emit(helper.bouble_jump_state)
