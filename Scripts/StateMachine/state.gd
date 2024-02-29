class_name State
extends Node

var actor: Node = null
var helper: Node = null

signal switch_state(new_state)


func set_actor(new_actor):
	actor = new_actor

func set_helper(new_helper):
	helper = new_helper

func enter_state():
	pass


func exit_state():
	pass


func physics_update(delta):
	pass
