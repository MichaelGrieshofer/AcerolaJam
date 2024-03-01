extends Node2D

@onready var sprite = $PlayerCharacterSheet

var frame: int = 0

func _ready():
	sprite.frame = frame


func _on_timer_timeout():
	queue_free()
