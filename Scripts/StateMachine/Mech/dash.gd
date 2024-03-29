extends State


@export var speed: float = 500
@export var distance: float = 0.2

@export var after_image: SpriteTrail
@export var after_image2: SpriteTrail

var time: float = 0


func enter_state():
	super()
	%Dash.play()
	actor.set_collision_mask_value(4,false)
	helper.start_water_punishment(0.5+distance)
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
	actor.set_collision_mask_value(4,true)
	after_image.emitting = false
	after_image2.emitting = false
	actor.velocity.x *= 0.25


func physics_update(delta):
	time -= delta
	if time <= 0.0:
		if (Input.is_action_pressed("jump") or Input.is_action_pressed("jboost")) and (helper.piloted or GameManager.remote_control) and Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_hover.tres"):
			switch_state.emit(helper.hover_state)
		else:
			switch_state.emit(helper.fall_state)
	actor.move_and_slide()
