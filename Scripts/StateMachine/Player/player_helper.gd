extends GenericMovementStateHelper

@onready var interaction = %Interaction
@onready var pcam = %PhantomCamera2D
@onready var after_image = %SpriteTrail

@export var double_jump_state: State
@export var dive_rebound_state: State
@export var dive_kick_state: State
@export var wall_jump_state: State
@export var wall_surf_state: State
@export var surf_state: State
@export var surf_jump_state: State
@export var surf_fall_state: State
@export var surf_double_jump_state: State

var has_double_jump: bool = true

func _ready():
	pcam.set_priority(1)
	Signals.player_left_mech.connect(leave_mech)


func _physics_process(delta):
	super(delta)
	if Input.is_action_just_pressed("up") and interaction.in_mech_area:
		state_machine.active = false
		dir = 0.0
		pcam.set_priority(0)
		state_machine.change_state(idle_state)
		actor.hide()
		Signals.player_entered_mech.emit()
	if actor.is_on_floor():
		has_double_jump = true


func leave_mech(position):
	pcam.set_priority(1)
	actor.global_position = position
	actor.velocity = Vector2(0,0)
	state_machine.active = true
	state_machine.change_state(idle_state)
	actor.show()


func toggle_after_image(active):
	after_image.emitting = active
