class_name FiniteStateMachine
extends Node

@export var state: State
@export var actor: Node
@export var helper: StateHelper
@export var active: bool = true

@export var print_test: bool = false

signal state_changed(new_state)

func _ready():
	init_states()
	change_state(state)
	if helper:
		helper.actor = actor
	helper.state_machine = self


func init_states():
	for i in get_children():
		if i is State:
			i.set_actor(actor)
			i.set_helper(helper)
			i.switch_state.connect(change_state)


func change_state(new_state: State):
	if !active:
		return
	if !state is State:
		return
	state.exit_state()
	new_state.enter_state()
	state = new_state
	state_changed.emit(new_state.name)


func _physics_process(delta):
	if !active:
		return
	if print_test:
		print(state)
	if state is State:
		state.physics_update(delta)
