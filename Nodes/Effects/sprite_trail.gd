extends Node2D

@onready var after_image = preload("res://Nodes/Effects/character_after_image.tscn")
@export var emitting: bool = false
@export var every_x_frames: int = 3

var i: int = 0

func _physics_process(delta):
	if !emitting:
		return
	i += 1
	if i == every_x_frames:
		i = 0
		var new_image = after_image.instantiate()
		new_image.frame = get_parent().frame
		new_image.scale = get_parent().scale
		new_image.global_position = global_position
		add_child(new_image)
