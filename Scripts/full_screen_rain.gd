extends Node2D

@onready var sound = $AudioStreamPlayer

func _ready():
	Signals.player_entered_inside.connect(inside)
	Signals.player_exited_inside.connect(outside)


func inside():
	sound.set_bus("RainLowPass")


func outside():
	sound.set_bus("Rain")
