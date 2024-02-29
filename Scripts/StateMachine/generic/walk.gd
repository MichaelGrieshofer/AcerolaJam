extends State

@export var acceleration: float = 0.05
@export var speed: float = 90

func physics_update(delta):
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.dir,acceleration)
	if helper.dir == 0:
		switch_state.emit(helper.idle_state)
	helper.check_for_fall()
	helper.check_for_jump()
	actor.move_and_slide()
