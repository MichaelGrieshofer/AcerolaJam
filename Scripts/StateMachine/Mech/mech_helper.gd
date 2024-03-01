extends GenericMovementStateHelper

@onready var pcam = %PhantomCamera2D

@export var hover_state: State

var player_control: bool = false

func _ready():
	Signals.player_entered_mech.connect(activate)
	jump.connect(check_for_hover)

func _physics_process(delta):
	if player_control:
		super(delta)
		if Input.is_action_just_pressed("down"):
			player_control = false
			dir = 0.0
			state_machine.change_state(idle_state)
			pcam.set_priority(0)
			Signals.player_left_mech.emit(actor.global_position)


func activate():
	pcam.set_priority(1)
	player_control = true


func check_for_hover():
	if state_machine.state == fall_state and !ct.time_left > 0:
		state_machine.change_state(hover_state)
