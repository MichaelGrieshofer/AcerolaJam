extends State


@export var speed: float = 500
@export var distance: float = 0.2

@export var after_image: SpriteTrail
@export var after_image2: SpriteTrail

var time: float = 0


func enter_state():
	super()
	helper.water.modify_health(-helper.dash_cost)
	after_image.emitting = true
	after_image2.emitting = true
	actor.velocity.y = 0
	if helper.dir != 0:
		actor.velocity.x = speed * helper.dir
	else:
		actor.velocity.x = speed * helper.look_dir
	time = distance


func exit_state():
	super()
	after_image.emitting = false
	after_image2.emitting = false
	actor.velocity.x *= 0.25


func physics_update(delta):
	time -= delta
	if time <= 0.0:
		if (Input.is_action_pressed("jump") or Input.is_action_pressed("jboost")) and helper.piloted:
			switch_state.emit(helper.hover_state)
		else:
			switch_state.emit(helper.fall_state)
	actor.move_and_slide()
