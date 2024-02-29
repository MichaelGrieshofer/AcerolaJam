extends GenericMovementStateHelper

var player_control: bool = false

func _ready():
	Signals.player_entered_mech.connect(activate)

func _physics_process(delta):
	if player_control:
		super(delta)
	if Input.is_action_just_pressed("down"):
		player_control = false
		dir = 0.0
		state_machine.change_state(idle_state)
		Signals.player_left_mech.emit(actor.global_position)


func activate():
	player_control = true
