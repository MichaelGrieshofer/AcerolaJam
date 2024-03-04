class_name SpriteTrail
extends Node2D

@onready var after_image = preload("res://Nodes/Effects/character_after_image.tscn")
@export var emitting: bool = false
@export var every_x_frames: int = 3
@export var target: Sprite2D
@export var copy_rotation: Node2D

var i: int = 0

func _physics_process(delta):
	global_position = target.global_position
	rotation = target.rotation
	if !emitting:
		return
	i += 1
	if i == every_x_frames:
		i = 0
		var new_image = after_image.instantiate()
		new_image.texture = target.texture
		new_image.hframes = target.hframes
		new_image.vframes = target.vframes
		new_image.frame = target.frame
		new_image.scale = target.scale
		new_image.global_position = global_position
		new_image.rotation = rotation
		
		if copy_rotation:
			new_image.rotation = copy_rotation.rotation
		
		add_child(new_image)
