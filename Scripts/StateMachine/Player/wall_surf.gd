extends State

@export var speed: float = 130
@export var acceleration: float = 0.02
@export var wall_jump_speed: float = 100

func enter_state():
	super()
	%Surf.play()
	helper.has_double_jump = true
	actor.velocity.y = -abs(actor.velocity.x)
	helper.toggle_after_image(true)


func exit_state():
	super()
	%Surf.stop()
	helper.toggle_after_image(false)


func physics_update(delta):
	actor.velocity.y = lerp(actor.velocity.y,-speed,acceleration)
	actor.velocity.x = 5*helper.look_dir
	
	if !actor.is_on_wall():
		end_surf()
	
	if actor.is_on_ceiling():
		end_surf()
		actor.velocity.x = -wall_jump_speed*helper.look_dir
	
	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("jjump"):
		actor.velocity.x = -wall_jump_speed*helper.look_dir
		if Save.check_for_ability("res://Resources/CustomResources/Abilities/surf.tres"):
			switch_state.emit(helper.surf_jump_state)
		else:
			switch_state.emit(helper.jump_state)
	
	actor.move_and_slide()


func _input(event):
	if !active:
		return
	if event.is_action_released("surf") or event.is_action_released("jsurf"):
		end_surf()


func end_surf():
	if Save.check_for_ability("res://Resources/CustomResources/Abilities/surf.tres"):
		switch_state.emit(helper.surf_fall_state)
	else:
		switch_state.emit(helper.fall_state)
