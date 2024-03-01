extends GenericMovementStateHelper

@onready var interaction = %Interaction
@onready var pcam = %PhantomCamera2D

var in_control: bool = true


func _ready():
	Signals.player_left_mech.connect(leave_mech)


func _physics_process(delta):
	if in_control:
		super(delta)
	if Input.is_action_just_pressed("up") and interaction.in_mech_area:
		in_control = false
		dir = 0.0
		pcam.set_priority(0)
		state_machine.change_state(idle_state)
		actor.hide()
		Signals.player_entered_mech.emit()


func leave_mech(position):
	pcam.set_priority(1)
	actor.global_position = position
	in_control = true
	actor.show()
