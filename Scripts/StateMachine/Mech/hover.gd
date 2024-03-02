extends State

@export var propulsion: float = 200
@export var max_propulsion: float = 100
@export var acceleration: float = 0.05
@export var speed: float = 90


func physics_update(delta):
	actor.velocity.y -= propulsion * delta
	if actor.velocity.y <= -max_propulsion:
		actor.velocity.y = -max_propulsion
	if Input.is_action_just_released("jump") or Input.is_action_just_released("jjump"):
		end_hover()
	air_control()
	actor.move_and_slide()


func end_hover():
	switch_state.emit(helper.fall_state)


func air_control():
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.dir,acceleration)
