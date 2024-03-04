extends GenericMovementStateHelper

@onready var interaction = %Interaction
@onready var pcam = %PhantomCamera2D
@onready var after_image = %SpriteTrail
@onready var health = %HealthManager

@export var double_jump_state: State
@export var dive_rebound_state: State
@export var dive_kick_state: State
@export var wall_jump_state: State
@export var wall_surf_state: State
@export var surf_state: State
@export var surf_jump_state: State
@export var surf_fall_state: State
@export var surf_double_jump_state: State
@export var bouble_jump_state: State

@export var rain_damage: float = 5

var has_double_jump: bool = true
var in_mech: bool = false

func _ready():
	pcam.set_priority(1)
	Signals.player_left_mech.connect(leave_mech)
	Signals.place_player.connect(place)
	Signals.pilot_mech.connect(enter_mech)


func place(pos):
	actor.global_position = pos


func _physics_process(delta):
	super(delta)
	if !in_mech and !interaction.in_inside_area:
		health.modify_health(-rain_damage*delta)
	elif in_mech and !interaction.in_inside_area:
		health.modify_health(rain_damage*delta)
	if (Input.is_action_just_pressed("enter_mech") or Input.is_action_just_pressed("jenter_mech")) and interaction.in_mech_area:
		enter_mech()
	if actor.is_on_floor():
		has_double_jump = true


func enter_mech():
	in_mech = true
	state_machine.active = false
	actor.global_position = Vector2.DOWN*1000000
	dir = 0.0
	pcam.set_priority(0)
	state_machine.change_state(idle_state)
	body.hide()
	after_image.emitting = false
	Signals.player_entered_mech.emit()


func leave_mech(position):
	in_mech = false
	pcam.set_priority(1)
	actor.global_position = position
	actor.velocity = Vector2(0,0)
	state_machine.active = true
	state_machine.change_state(idle_state)
	body.show()


func toggle_after_image(active):
	after_image.emitting = active


func _on_health_manager_health_depleted():
	Transition.load_level()
