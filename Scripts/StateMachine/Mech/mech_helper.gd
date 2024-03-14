extends GenericMovementStateHelper

@onready var pcam = %PhantomCamera2D
@onready var arm = %Arm
@onready var arm_top_level = %ArmTopLevel
@onready var water = %Water
@onready var hp = %HealthManager
@onready var water_pu_timer = %WaterPunishmentTimer

@export var hover_state: State
@export var dash_state: State
@export var dash_cost: float = 50
@export var water_recovery: float = 20
@export var water_recovery_floor: float = 50

var piloted: bool = false
var aim_dir: Vector2 = Vector2.ZERO
var mouse: Vector2 = Vector2.ZERO
var aim_mode: bool = false
var last_aim_dir: Vector2 = Vector2.ZERO
var last_aim_look_dir: int = 1

var water_punishment: bool = false


func _ready():
	Signals.player_entered_mech.connect(activate)
	Signals.place_mech.connect(place)
	Signals.pilot_mech.connect(activate)
	
	Signals.remote_control_started.connect(func():
		pcam.set_priority(2))
	Signals.remote_control_ended.connect(func():
		pcam.set_priority(0))
	
	Signals.update_mech_max_health.connect(update_mech_max_health)
	Signals.update_mech_fuel.connect(update_mech_max_fuel)
	Signals.set_camera_limits.connect(set_camera_limits)
	
	update_mech_max_fuel()
	update_mech_max_health()
	
	await get_tree().process_frame
	
	Signals.max_mech_fuel_changed.emit(water.max_health)
	Signals.mech_fuel_changed.emit(water.current_hp)
	Signals.max_mech_health_changed.emit(hp.max_health)
	Signals.mech_health_changed.emit(hp.current_hp)


func set_camera_limits(left,top,right,bottom):
	pcam.limit_left = left
	pcam.limit_top = top
	pcam.limit_right = right
	pcam.limit_bottom = bottom


func update_mech_max_health():
	hp.max_health = 1000
	if Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_health_0.tres"):
		hp.max_health += 1000
		hp.current_hp += 1000
	if Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_health_1.tres"):
		hp.max_health += 1000
		hp.current_hp += 1000
	if Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_health_2.tres"):
		hp.max_health += 1000
		hp.current_hp += 1000
	if Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_health_3.tres"):
		hp.max_health += 1000
		hp.current_hp += 1000
	Signals.max_mech_health_changed.emit(hp.max_health)
	Signals.mech_health_changed.emit(hp.current_hp)


func update_mech_max_fuel():
	water.max_health = 50
	if Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_water_0.tres"):
		water.max_health += 50
		water.current_hp += 50
	if Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_water_1.tres"):
		water.max_health += 50
		water.current_hp += 50
	if Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_water_2.tres"):
		water.max_health += 50
		water.current_hp += 50
	if Save.check_for_ability("res://Resources/CustomResources/Abilities/mech_water_3.tres"):
		water.max_health += 50
		water.current_hp += 50
	Signals.max_mech_fuel_changed.emit(water.max_health)
	Signals.mech_fuel_changed.emit(water.current_hp)


func place(pos):
	actor.global_position = pos


func _physics_process(delta):
	GameManager.mech_position = actor.global_position
	arm_top_level.global_position = arm.global_position
	if state_machine.state != hover_state and !water_punishment and actor.is_on_floor():
		water.modify_health(+(water.max_health/100)*water_recovery_floor*delta)
	if state_machine.state != hover_state and !water_punishment and !actor.is_on_floor():
		water.modify_health(+(water.max_health/100)*water_recovery*delta)
	if (piloted or GameManager.remote_control):
		get_direction()
		set_body_look_direction()
		if actor.is_on_floor():
			ct.start()
		aim()
		if (Input.is_action_just_pressed("enter_mech") or Input.is_action_just_pressed("jenter_mech")) and state_machine.state == idle_state and !GameManager.remote_control:
			piloted = false
			dir = 0.0
			state_machine.change_state(idle_state)
			pcam.set_priority(0)
			Transition.last_mech_position = actor.global_position
			Signals.player_left_mech.emit(actor.global_position)
		if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("jboost"):
			ib.start()


func aim():
	mouse = actor.get_global_mouse_position()
	aim_dir = mouse - actor.position
	aim_dir = aim_dir.normalized()
	
	var controller_aim = Input.get_vector("jaim_left","jaim_right","jaim_up","jaim_down")
	controller_aim = controller_aim.normalized()
	if GameManager.controller:
		aim_dir = controller_aim
		
	if Input.is_action_pressed("aim") or controller_aim != Vector2.ZERO:
		aim_mode = true
	else:
		aim_mode = false
		
	if !aim_dir == Vector2.ZERO and aim_mode:
		arm_top_level.rotation = lerp_angle(arm_top_level.rotation,aim_dir.angle(),0.5)
		last_aim_dir = aim_dir
		last_aim_look_dir = look_dir
	else:
		var ang
		if last_aim_look_dir == look_dir:
			ang = Vector2(last_aim_dir.x,last_aim_dir.y).angle()
		else:
			ang = Vector2(last_aim_dir.x * -1,last_aim_dir.y).angle()
		arm_top_level.rotation = lerp_angle(arm_top_level.rotation,ang,0.5)


func set_body_look_direction():
	if aim_mode:
		if aim_dir.x > 0: 
			look_dir = 1
		elif aim_dir.x < 0:
			look_dir = -1
		body.scale.x = look_dir
	else:
		if abs(actor.velocity.x) >= 0.1:
			if actor.velocity.x > 0: 
				look_dir = 1
			elif actor.velocity.x < 0:
				look_dir = -1
		body.scale.x = look_dir


func activate():
	GameManager.remote_control = false
	pcam.set_priority(1)
	piloted = true


func _on_water_health_modified(amount, new_hp):
	Signals.mech_fuel_changed.emit(new_hp)


func _on_water_health_depleted():
	start_water_punishment(2)


func start_water_punishment(amount):
	water_punishment = true
	water_pu_timer.wait_time = amount
	water_pu_timer.start()


func _on_water_punishment_timer_timeout():
	water_punishment = false


func _on_health_manager_health_depleted():
	Transition.load_level()


func _on_health_manager_health_modified(amount, new_hp):
	Signals.mech_health_changed.emit(new_hp)


func footstep():
	%Footstep.play()
