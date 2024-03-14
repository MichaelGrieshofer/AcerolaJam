extends Node2D


@onready var con = $ActionIcon2
@onready var key =  $ActionIcon


func _physics_process(delta):
	if GameManager.controller:
		con.show()
		key.hide()
	else:
		con.hide()
		key.show()
