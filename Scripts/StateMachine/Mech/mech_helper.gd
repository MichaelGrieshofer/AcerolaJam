extends GenericMovementStateHelper

@onready var pcam = %PhantomCamera2D
@onready var arm = %Arm
@onready var arm_top_level = %ArmTopLevel

@export var hover_state: State
@export var dash_state: State

var piloted: bool = false
var aim_dir: Vector2 = Vector2.ZERO
var mouse: Vector2 = Vector2.ZERO
var aim_mode: bool = false
var last_aim_dir: Vector2 = Vector2.ZERO
var last_aim_look_dir: int = 1

var controller: bool = false

func _ready():
	Signals.player_entered_mech.connect(activate)
	Signals.place_mech.connect(place)
	Signals.pilot_mech.connect(activate)


func place(pos):
	actor.global_position = pos


func _physics_process(delta):
	arm_top_level.global_position = arm.global_position
	if piloted:
		get_direction()
		set_body_look_direction()
		if actor.is_on_floor():
			ct.start()
		aim()
		if Input.is_action_just_pressed("enter_mech") or Input.is_action_just_pressed("jenter_mech"):
			piloted = false
			dir = 0.0
			state_machine.change_state(idle_state)
			pcam.set_priority(0)
			Transition.last_mech_position = actor.global_position
			Signals.player_left_mech.emit(actor.global_position)
		if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("jboost"):
			ib.start()


func _input(event):
	if event is InputEventMouseMotion or event is InputEventKey:
		controller = false
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		controller = true


func aim():
	mouse = actor.get_global_mouse_position()
	aim_dir = mouse - actor.position
	aim_dir = aim_dir.normalized()
	
	var controller_aim = Input.get_vector("jaim_left","jaim_right","jaim_up","jaim_down")
	controller_aim = controller_aim.normalized()
	if controller:
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
	pcam.set_priority(1)
	piloted = true
