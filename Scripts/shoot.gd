extends Node2D

@export var copy_angle: Node2D
@export var ever_x_frames: int = 5
@export var helper: Node

@onready var bullet = preload("res://Nodes/Actors/bullet.tscn")

var i: int = 0

func _physics_process(delta):
	if (Input.is_action_pressed("shoot") or Input.is_action_pressed("jshoot")) and helper.piloted:
		shoot()

func shoot():
	i += 1
	if i == ever_x_frames:
		i = 0
		var new_bullet = bullet.instantiate()
		new_bullet.dir = Vector2.RIGHT.rotated(copy_angle.rotation)
		new_bullet.global_position = global_position
		add_child(new_bullet)
