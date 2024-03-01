extends State

@export var propulsion: float = 200
@export var max_propulsion: float = 100
@export var acceleration: float = 0.05
@export var speed: float = 90


func set_helper(new_helper):
	super(new_helper)
	helper.jump_cancel.connect(end_hover)


func physics_update(delta):
	actor.velocity.y -= propulsion * delta
	if actor.velocity.y <= -max_propulsion:
		actor.velocity.y = -max_propulsion
	air_control()
	actor.move_and_slide()


func end_hover():
	switch_state.emit(helper.fall_state)


func air_control():
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.dir,acceleration)
