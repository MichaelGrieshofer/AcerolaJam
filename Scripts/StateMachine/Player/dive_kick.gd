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
	helper.toggle_after_image(false)


func physics_update(delta):
	if actor.is_on_floor() and !Input.is_action_pressed("surf"):
		switch_state.emit(helper.dive_rebound_state)
	if actor.is_on_floor() and Input.is_action_pressed("surf"):
		actor.velocity.x *= dive_into_surf_momentum_loss
		switch_state.emit(helper.surf_state)
	if actor.is_on_wall() and !Input.is_action_pressed("surf"):
		helper.has_double_jump = true
		switch_state.emit(helper.wall_jump_state)
	if actor.is_on_wall() and Input.is_action_pressed("surf"):
		actor.velocity.x = 0
		switch_state.emit(helper.wall_surf_state)
	if Input.is_action_just_pressed("jump") and helper.has_double_jump and Input.is_action_pressed("surf"):
		helper.has_double_jump = false
		switch_state.emit(helper.surf_double_jump_state)
	if Input.is_action_just_pressed("jump") and helper.has_double_jump:
		helper.has_double_jump = false
		switch_state.emit(helper.double_jump_state)
	actor.move_and_slide()
