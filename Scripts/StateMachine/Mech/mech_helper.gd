extends GenericMovementStateHelper

@onready var pcam = %PhantomCamera2D

@export var hover_state: State

var piloted: bool = false

func _ready():
	Signals.player_entered_mech.connect(activate)

func _physics_process(delta):
	if piloted:
		super(delta)
		if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("jdown"):
			piloted = false
			dir = 0.0
			state_machine.change_state(idle_state)
			pcam.set_priority(0)
			Signals.player_left_mech.emit(actor.global_position)


func activate():
	pcam.set_priority(1)
	piloted = true
