class_name FiniteStateMachine
extends Node

@export var state: State
@export var actor: Node

signal state_changed(new_state)

func _ready():
	init_states()
	change_state(state)


func init_states():
	for i in get_children():
		if i is State:
			i.set_actor(actor)
			i.switch_state.connect(change_state)


func change_state(new_state: State):
	if !state is State:
		return
	state.exit_state()
	new_state.enter_state()
	state = new_state
	state_changed.emit(new_state.name)


func _physics_process(delta):
	if state is State:
		state.physics_update(delta)
