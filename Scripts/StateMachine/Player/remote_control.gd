extends State

@export var deceleration: float = 0.2

func physics_update(delta):
	if helper.dir == 0:
		actor.velocity.x = lerp(actor.velocity.x,0.0,deceleration)
	if (Input.is_action_just_pressed("remote_control") or Input.is_action_just_pressed("jremote_control")):
		switch_state.emit(helper.idle_state)
	actor.move_and_slide()

func enter_state():
	super()
	GameManager.remote_control = true
	Signals.remote_control_started.emit()


func exit_state():
	super()
	GameManager.remote_control = false
	Signals.remote_control_ended.emit()
