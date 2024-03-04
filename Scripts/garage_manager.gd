extends Node2D

@onready var transition_point = $TransitionArea

func _ready():
	transition_point.tag = Transition.last_garage_tag
	transition_point.target_scene = Transition.last_garage_area
