extends State

@export var speed: float = 130
@export var acceleration: float = 0.02
@export var wall_jump_speed: float = 100

func enter_state():
	super()
	helper.has_double_jump = true
	actor.velocity.y = -abs(actor.velocity.x)
	helper.toggle_after_image(true)


func exit_state():
	helper.toggle_after_image(false)


func physics_update(delta):
	actor.velocity.y = lerp(actor.velocity.y,-speed,acceleration)
	actor.velocity.x = 5*helper.look_dir
	
	if !actor.is_on_wall() or (Input.is_action_just_released("surf") or Input.is_action_just_released("jsurf")):
		switch_state.emit(helper.surf_fall_state)
	
	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("jjump"):
		switch_state.emit(helper.surf_jump_state)
		actor.velocity.x = -wall_jump_speed*helper.look_dir
	
	if actor.is_on_ceiling():
		switch_state.emit(helper.surf_fall_state)
		actor.velocity.x = -wall_jump_speed*helper.look_dir
	
	actor.move_and_slide()
