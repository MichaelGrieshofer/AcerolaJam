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
@export var health_regen: float = 20

var has_double_jump: bool = true
var in_mech: bool = false

func _ready():
	pcam.set_priority(1)
	Signals.player_left_mech.connect(leave_mech)
	Signals.place_player.connect(place)
	Signals.pilot_mech.connect(enter_mech)
	Signals.update_player_max_health.connect(update_player_max_health)
	
	update_player_max_health()
	
	await get_tree().process_frame
	
	Signals.max_player_health_changed.emit(health.max_health)
	Signals.player_health_changed.emit(health.current_hp)


func update_player_max_health():
	health.max_health = 100
	if Save.check_for_ability("res://Resources/CustomResources/Abilities/player_health_0.tres"):
		health.max_health += 100
		health.current_hp += 100
	if Save.check_for_ability("res://Resources/CustomResources/Abilities/player_health_1.tres"):
		health.max_health += 100
		health.current_hp += 100
	if Save.check_for_ability("res://Resources/CustomResources/Abilities/player_health_2.tres"):
		health.max_health += 100
		health.current_hp += 100
	if Save.check_for_ability("res://Resources/CustomResources/Abilities/player_health_3.tres"):
		health.max_health += 100
		health.current_hp += 100
	Signals.max_player_health_changed.emit(health.max_health)
	Signals.player_health_changed.emit(health.current_hp)


func place(pos):
	actor.global_position = pos


func _physics_process(delta):
	super(delta)
	GameManager.player_position = actor.global_position
	if !in_mech and !interaction.in_inside_area:
		health.modify_health(-rain_damage*delta)
	elif in_mech and !interaction.in_inside_area:
		health.modify_health(health_regen*delta)
	if (Input.is_action_just_pressed("enter_mech") or Input.is_action_just_pressed("jenter_mech")) and interaction.in_mech_area:
		enter_mech()
	if actor.is_on_floor():
		has_double_jump = true


func enter_mech():
	GameManager.player_outside_mech = false
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
	GameManager.player_outside_mech = true
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


func _on_health_manager_health_modified(amount, new_hp):
	Signals.player_health_changed.emit(new_hp)


func _on_hurtbox_destroy_player_triggered():
	actor.global_position = Transition.last_checkpoint_pos
