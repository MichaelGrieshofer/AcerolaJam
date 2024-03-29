extends State

@export var propulsion: float = 200
@export var max_propulsion: float = 100
@export var acceleration: float = 0.05
@export var speed: float = 90
@export var hover_cost: float = 50
@export var boosters: Boosters


func physics_update(delta):
	actor.velocity.y -= propulsion * delta
	
	helper.water.modify_health(-hover_cost*delta)
	
	if actor.velocity.y <= -max_propulsion:
		actor.velocity.y = -max_propulsion
	
	if Input.is_action_just_released("jump") or Input.is_action_just_released("jboost"):
		end_hover()
	
	if (Input.is_action_just_pressed("dash") or Input.is_action_just_pressed("jdash")):
		if (helper.piloted or GameManager.remote_control) and helper.water.current_hp > 0 and Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_dash.tres"):
			switch_state.emit(helper.dash_state)
	
	air_control()
	actor.move_and_slide()


func end_hover():
	switch_state.emit(helper.fall_state)


func air_control():
	actor.velocity.x = lerp(actor.velocity.x,speed*helper.dir,acceleration)


func enter_state():
	super()
	boosters.emit(true)
	%Jet.play()


func exit_state():
	super()
	boosters.emit(false)
	helper.start_water_punishment(0.25)
	%Jet.stop()

func _on_water_health_depleted():
	if active:
		end_hover()
