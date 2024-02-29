extends GenericMovementStateHelper

@onready var interaction = %Interaction

var in_control: bool = true


func _ready():
	Signals.player_left_mech.connect(leave_mech)


func _physics_process(delta):
	if in_control:
		super(delta)
	if Input.is_action_just_pressed("up") and interaction.in_mech_area:
		in_control = false
		actor.hide()
		Signals.player_entered_mech.emit()


func leave_mech(position):
	actor.global_position = position
	in_control = true
	actor.show()
