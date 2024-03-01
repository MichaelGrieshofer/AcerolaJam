extends FallState

@export var surf: bool = false

func enter_state():
	super()
	if surf:
		helper.toggle_after_image(true)


func exit_state():
	if surf:
		helper.toggle_after_image(false)

func physics_update(delta):
	super(delta)
	if Input.is_action_just_pressed("jump") and helper.has_double_jump and Input.is_action_pressed("surf") and surf:
		helper.has_double_jump = false
		switch_state.emit(helper.surf_double_jump_state)
	if Input.is_action_just_pressed("jump") and helper.has_double_jump and helper.ct.time_left == 0:
		helper.has_double_jump = false
		switch_state.emit(helper.double_jump_state)
	if Input.is_action_just_pressed("divekick"):
		switch_state.emit(helper.dive_kick_state)
	if actor.is_on_wall() and Input.is_action_pressed("surf"):
		switch_state.emit(helper.wall_surf_state)
	if surf and Input.is_action_just_released("surf"):
		switch_state.emit(helper.fall_state)

func air_control():
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.dir,acceleration)
