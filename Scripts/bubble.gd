class_name Bubble
extends Area2D

@onready var anim = $Bubble/AnimationPlayer
@onready var timer = $Timer
@onready var shape = $CollisionShape2D

func _ready():
	anim.play("idle")


func pop():
	timer.start()
	anim.play("linger")
	shape.disabled = true


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "pop":
		anim.play("idle")


func _on_timer_timeout():
	anim.play_backwards("pop")
	shape.disabled = false
