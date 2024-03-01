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
	helper.toggle_after_image(false)


func physics_update(delta):
	super(delta)
	if actor.velocity.y >= 0 and surf and Input.is_action_pressed("surf"):
		switch_state.emit(helper.surf_fall_state)
	if Input.is_action_just_pressed("jump") and helper.has_double_jump and Input.is_action_pressed("surf") and surf:
		helper.has_double_jump = false
		switch_state.emit(helper.surf_double_jump_state)
	if Input.is_action_just_pressed("jump") and helper.has_double_jump:
		helper.has_double_jump = false
		switch_state.emit(helper.double_jump_state)
	if Input.is_action_just_pressed("divekick") and dive_kick_cancelable:
		switch_state.emit(helper.dive_kick_state)
	if actor.is_on_wall() and Input.is_action_pressed("surf"):
		switch_state.emit(helper.wall_surf_state)
