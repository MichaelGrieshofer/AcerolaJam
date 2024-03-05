class_name Checkpoint
extends Area2D

@export var update_position: bool = false

@onready var spawn_location = $SpawnLocation.global_position


func _physics_process(delta):
	if update_position:
		spawn_location = $SpawnLocation.global_position
